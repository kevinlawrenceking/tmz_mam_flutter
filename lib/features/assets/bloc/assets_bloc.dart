import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/models/asset_search_data.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/send_to.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'assets_bloc_event.dart';
part 'assets_bloc_state.dart';

class AssetsBloc extends Bloc<AssetsBlocEvent, AssetsBlocState> {
  final IAssetDataSource assetDataSource;
  final ICollectionDataSource collectionDataSource;

  AssetSearchDataModel? _advancedSearchData;

  String? _simpleSearchCollectionID;
  String? _simpleSearchTerm;

  int _offset = 0;
  int _limit = 100;
  AssetSortFieldEnum _sortField = AssetSortFieldEnum.createdAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;

  var _totalRecords = 0;

  AssetsBloc({
    required this.assetDataSource,
    required this.collectionDataSource,
  }) : super(InitialState()) {
    on<AddAssetsToCollectionEvent>(_addAssetsToCollectionEvent);
    on<DeleteAssetEvent>(_deleteAssetEvent);
    on<MoveAssetsToCollectionEvent>(_moveAssetsToCollectionEvent);
    on<PaginationChangedEvent>(_paginationChangedEvent);
    on<RefreshEvent>(_refreshEvent);
    on<ReloadCurrentPageEvent>(_reloadCurrentPageEvent);
    on<RemoveAssetsFromCollectionEvent>(_removeAssetsFromCollectionEvent);
    on<SearchAdvancedEvent>(_searchAdvancedEvent);
    on<SearchSimpleEvent>(_searchSimpleEvent);
    on<SendAssetsToEvent>(_sendAssetsToEvent);
    on<SetCurrentCollectionEvent>(_setCurrentCollectionEvent);
  }

  Future<void> _addAssetsToCollectionEvent(
    AddAssetsToCollectionEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.assetIDs.isEmpty) {
      return;
    }

    for (var i = 0; i < event.assetIDs.length; i++) {
      final result = await collectionDataSource.addAssetToCollection(
        collectionID: event.collectionID,
        assetID: event.assetIDs[i],
      );

      result.fold(
        (failure) => emit(AddAssetsToCollectionFailureState(failure)),
        (_) {},
      );

      if (result.isLeft()) {
        return;
      }
    }

    emit(AddAssetsToCollectionSuccessState());
  }

  Future<void> _deleteAssetEvent(
    DeleteAssetEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.assetIDs.isEmpty) {
      return;
    }

    for (var i = 0; i < event.assetIDs.length; i++) {
      final result = await assetDataSource.deleteAsset(
        assetID: event.assetIDs[i],
      );

      result.fold(
        (failure) => emit(DeleteAssetFailureState(failure)),
        (_) {},
      );

      if (result.isLeft()) {
        return;
      }
    }

    emit(DeleteAssetSuccessState());

    await _search(
      emit: emit,
    );
  }

  Future<void> _moveAssetsToCollectionEvent(
    MoveAssetsToCollectionEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.assetIDs.isEmpty) {
      return;
    }

    for (var i = 0; i < event.assetIDs.length; i++) {
      final result = await collectionDataSource.moveAssetToCollection(
        sourceCollectionID: event.sourceCollectionID,
        targetCollectionID: event.targetCollectionID,
        assetID: event.assetIDs[i],
      );

      result.fold(
        (failure) => emit(MoveAssetsToCollectionFailureState(failure)),
        (_) {},
      );

      if (result.isLeft()) {
        return;
      }
    }

    emit(MoveAssetsToCollectionSuccessState());

    await _search(
      emit: emit,
    );
  }

  Future<void> _paginationChangedEvent(
    PaginationChangedEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    _offset = event.offset;
    _limit = event.limit;

    await _search(
      emit: emit,
    );
  }

  Future<void> _refreshEvent(
    RefreshEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    _offset = 0;

    await _search(
      emit: emit,
    );
  }

  Future<void> _reloadCurrentPageEvent(
    ReloadCurrentPageEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    await _search(
      emit: emit,
    );
  }

  Future<void> _removeAssetsFromCollectionEvent(
    RemoveAssetsFromCollectionEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.assetIDs.isEmpty) {
      return;
    }

    for (var i = 0; i < event.assetIDs.length; i++) {
      final result = await collectionDataSource.removeAssetFromCollection(
        collectionID: event.collectionID,
        assetID: event.assetIDs[i],
      );

      result.fold(
        (failure) => emit(RemoveAssetsFromCollectionFailureState(failure)),
        (_) {},
      );

      if (result.isLeft()) {
        return;
      }
    }

    emit(RemoveAssetsFromCollectionSuccessState());

    await _search(
      emit: emit,
    );
  }

  Future<void> _searchAdvancedEvent(
    SearchAdvancedEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    _advancedSearchData = event.searchData;

    _simpleSearchCollectionID = null;
    _simpleSearchTerm = null;

    _offset = 0;
    _totalRecords = 0;

    await _search(
      emit: emit,
    );
  }

  Future<void> _searchSimpleEvent(
    SearchSimpleEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.searchTerm != null) {
      _simpleSearchTerm = event.searchTerm;
    }

    _advancedSearchData = null;

    _offset = 0;
    _sortField = event.sortField;
    _sortDirection = event.sortDirection;
    _totalRecords = 0;

    await _search(
      emit: emit,
    );
  }

  Future<void> _sendAssetsToEvent(
    SendAssetsToEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    if (event.assetIDs.isEmpty) {
      return;
    }

    for (var i = 0; i < event.assetIDs.length; i++) {
      await assetDataSource.sendAssetTo(
        assetID: event.assetIDs[i],
        sendToID: event.sendToID,
      );
    }

    emit(AssetsSentState());
    emit(InitialState());
  }

  Future<void> _setCurrentCollectionEvent(
    SetCurrentCollectionEvent event,
    Emitter<AssetsBlocState> emit,
  ) async {
    _offset = 0;
    _totalRecords = 0;
    _simpleSearchCollectionID = event.collectionID;

    await _search(
      emit: emit,
    );
  }

  Future<void> _search({
    required Emitter<AssetsBlocState> emit,
  }) async {
    if (_advancedSearchData != null) {
      await _searchAdvanced(
        emit: emit,
        searchData: _advancedSearchData!,
        offset: _offset,
        limit: _limit,
        sortField: _sortField,
        sortDirection: _sortDirection,
      );
    } else {
      await _searchSimple(
        emit: emit,
        collectionID: _simpleSearchCollectionID,
        searchTerm: _simpleSearchTerm,
        offset: _offset,
        limit: _limit,
        sortField: _sortField,
        sortDirection: _sortDirection,
      );
    }
  }

  Future<void> _searchAdvanced({
    required Emitter<AssetsBlocState> emit,
    required AssetSearchDataModel searchData,
    required int offset,
    required int limit,
    required AssetSortFieldEnum? sortField,
    required SortDirectionEnum? sortDirection,
  }) async {
    emit(
      PaginationChangedState(
        offset: offset,
        limit: limit,
        totalRecords: _totalRecords,
      ),
    );

    emit(SearchResultsLoadingState());

    final conditions = <AssetSearchDataMetadataConditionModel>[];

    for (var i = 0; i < searchData.metadataConditions.length; i++) {
      final condition = searchData.metadataConditions[i];

      switch (condition.field) {
        case AssetSearchMetadataFieldEnum.createdBy:
          conditions.add(
            condition.copyWithValue(
              (condition.value as List<UserMetaModel>?)
                  ?.map((_) => _.userID)
                  .toList(),
            ),
          );
          break;
        case AssetSearchMetadataFieldEnum.creditLocation:
          conditions.add(
            condition.copyWithValue(
              (condition.value as AssetMetadataCreditLocationEnum?)
                  ?.toJsonDtoValue(),
            ),
          );
          break;
        case AssetSearchMetadataFieldEnum.emotions:
          conditions.add(
            condition.copyWithValue(
              (condition.value as List<AssetMetadataEmotionEnum>?)
                  ?.map((_) => _.toJsonDtoValue())
                  .toList(),
            ),
          );
          break;
        case AssetSearchMetadataFieldEnum.exclusivity:
          conditions.add(
            condition.copyWithValue(
              (condition.value as AssetMetadataExclusivityEnum?)
                  ?.toJsonDtoValue(),
            ),
          );
          break;
        case AssetSearchMetadataFieldEnum.overlays:
          conditions.add(
            condition.copyWithValue(
              (condition.value as List<AssetMetadataOverlayEnum>?)
                  ?.map((_) => _.toJsonDtoValue())
                  .toList(),
            ),
          );
          break;
        case AssetSearchMetadataFieldEnum.rights:
          conditions.add(
            condition.copyWithValue(
              (condition.value as AssetMetadataRightsEnum?)?.toJsonDtoValue(),
            ),
          );
          break;
        default:
          conditions.add(condition);
          break;
      }
    }

    final result = await assetDataSource.searchAdvanced(
      searchData: AssetSearchDataModel(
        createdAtStart: searchData.createdAtStart?.toUtc(),
        createdAtEnd: searchData.createdAtEnd?.toUtc(),
        updatedAtStart: searchData.updatedAtStart?.toUtc(),
        updatedAtEnd: searchData.updatedAtEnd?.toUtc(),
        searchTerm: searchData.searchTerm,
        metadataConditions: conditions,
      ),
      offset: offset,
      limit: limit,
      sortField: sortField,
      sortDirection: sortDirection,
    );

    result.fold(
      (failure) => emit(SearchFailureState(failure)),
      (results) {
        _totalRecords = results.totalRecords;

        emit(
          PaginationChangedState(
            offset: offset,
            limit: limit,
            totalRecords: results.totalRecords,
          ),
        );

        emit(
          SearchResultsLoadedState(
            assets: results.assets,
          ),
        );
      },
    );
  }

  Future<void> _searchSimple({
    required Emitter<AssetsBlocState> emit,
    required String? collectionID,
    required String? searchTerm,
    required int offset,
    required int limit,
    required AssetSortFieldEnum? sortField,
    required SortDirectionEnum? sortDirection,
  }) async {
    emit(
      PaginationChangedState(
        offset: offset,
        limit: limit,
        totalRecords: _totalRecords,
      ),
    );

    emit(SearchResultsLoadingState());

    final result = await assetDataSource.searchSimple(
      collectionID: collectionID,
      searchTerm: searchTerm,
      offset: offset,
      limit: limit,
      sortField: sortField,
      sortDirection: sortDirection,
    );

    result.fold(
      (failure) => emit(SearchFailureState(failure)),
      (results) {
        _totalRecords = results.totalRecords;

        emit(
          PaginationChangedState(
            offset: offset,
            limit: limit,
            totalRecords: results.totalRecords,
          ),
        );

        emit(
          SearchResultsLoadedState(
            assets: results.assets,
          ),
        );
      },
    );

    final getSendToOptionsResult = await assetDataSource.getSendToOptions();

    getSendToOptionsResult.fold(
      (failure) {},
      (options) {
        emit(
          SendToOptionsState(
            options: options,
          ),
        );
      },
    );

    emit(InitialState());
  }
}
