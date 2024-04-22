import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class AssetsBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetDataSource assetDataSource;
  final ICollectionDataSource collectionDataSource;

  var _offset = 0;
  var _limit = 10;
  String? _collectionID;
  String? _searchTerm;
  AssetSortFieldEnum? _sortField;
  SortDirectionEnum? _sortDirection;

  var _totalRecords = 0;

  AssetsBloc({
    required this.assetDataSource,
    required this.collectionDataSource,
  }) : super(InitialState()) {
    on<AddAssetsToCollectionEvent>(_addAssetsToCollectionEvent);
    on<MoveAssetsToCollectionEvent>(_moveAssetsToCollectionEvent);
    on<PaginationChangedEvent>(_paginationChangedEvent);
    on<RefreshEvent>(_refreshEvent);
    on<ReloadCurrentPageEvent>(_reloadCurrentPageEvent);
    on<RemoveAssetsFromCollectionEvent>(_removeAssetsFromCollectionEvent);
    on<SearchEvent>(_searchEvent);
    on<SetCurrentCollectionEvent>(_setCurrentCollectionEvent);
  }

  Future<void> _addAssetsToCollectionEvent(
    AddAssetsToCollectionEvent event,
    Emitter<BlocState> emit,
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

  Future<void> _moveAssetsToCollectionEvent(
    MoveAssetsToCollectionEvent event,
    Emitter<BlocState> emit,
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

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _paginationChangedEvent(
    PaginationChangedEvent event,
    Emitter<BlocState> emit,
  ) async {
    _offset = event.offset;
    _limit = event.limit;

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _refreshEvent(
    RefreshEvent event,
    Emitter<BlocState> emit,
  ) async {
    _offset = 0;

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _reloadCurrentPageEvent(
    ReloadCurrentPageEvent event,
    Emitter<BlocState> emit,
  ) async {
    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _removeAssetsFromCollectionEvent(
    RemoveAssetsFromCollectionEvent event,
    Emitter<BlocState> emit,
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

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _searchEvent(
    SearchEvent event,
    Emitter<BlocState> emit,
  ) async {
    if (event.searchTerm != null) {
      _searchTerm = event.searchTerm;
    }

    _offset = 0;
    _sortField = event.sortField;
    _sortDirection = event.sortDirection;
    _totalRecords = 0;

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _setCurrentCollectionEvent(
    SetCurrentCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    _offset = 0;
    _totalRecords = 0;
    _collectionID = event.collectionID;

    await _getAssetList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      collectionID: _collectionID,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _getAssetList({
    required Emitter<BlocState> emit,
    required int offset,
    required int limit,
    required String? collectionID,
    required String? searchTerm,
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

    final result = await assetDataSource.getAssetList(
      offset: offset,
      limit: limit,
      collectionID: collectionID,
      searchTerm: searchTerm,
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
}
