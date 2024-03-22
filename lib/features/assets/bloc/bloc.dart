import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class AssetsBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetDataSource assetDataSource;

  var _offset = 0;
  var _limit = 10;
  String? _searchTerm;
  AssetSortFieldEnum? _sortField;
  SortDirectionEnum? _sortDirection;

  var _totalRecords = 0;

  AssetsBloc({
    required this.assetDataSource,
  }) : super(InitialState()) {
    on<LoadAssetDetailsEvent>(_loadAssetDetailsEvent);
    on<PaginationChangedEvent>(_paginationChangedEvent);
    on<RefreshEvent>(_refreshEvent);
    on<ReloadCurrentPageEvent>(_reloadCurrentPageEvent);
    on<SearchEvent>(_searchEvent);
  }

  Future<void> _loadAssetDetailsEvent(
    LoadAssetDetailsEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(AssetDetailsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetDataSource.getAssetDetails(
      assetID: event.assetID,
    );

    result.fold(
      (failure) => emit(AssetDetailsFailureState(failure)),
      (details) => emit(
        AssetDetailsLoadedState(
          model: details,
        ),
      ),
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
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _getAssetList({
    required Emitter<BlocState> emit,
    required int offset,
    required int limit,
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
