import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_mam_flutter/data/models/inventory.dart';
import 'package:tmz_mam_flutter/data/models/inventory_details.dart';
import 'package:tmz_mam_flutter/data/models/inventory_sort_field_enum.dart';
import 'package:tmz_mam_flutter/data/models/sort_direction_enum.dart';
import 'package:tmz_mam_flutter/data/sources/inventory.dart';
import 'package:tmz_mam_flutter/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class AssetsBloc extends Bloc<BlocEvent, BlocState> {
  final IInventoryDataSource inventoryDataSource;

  var _limit = 10;
  String? _searchTerm;
  InventorySortFieldEnum? _sortField;
  SortDirectionEnum? _sortDirection;

  var _totalRecords = 0;

  AssetsBloc({
    required this.inventoryDataSource,
  }) : super(InitialState()) {
    on<LoadInventoryDetailsEvent>(_loadInventoryDetailsEvent);
    on<PaginationChangedEvent>(_paginationChangedEvent);
    on<SearchEvent>(_searchEvent);
  }

  Future<void> _loadInventoryDetailsEvent(
    LoadInventoryDetailsEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(InventoryDetailsLoadingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await inventoryDataSource.getInventoryDetails(
      itemID: event.itemID,
    );

    result.fold(
      (failure) => emit(InventoryDetailsFailureState(failure)),
      (details) => emit(
        InventoryDetailsLoadedState(
          model: details,
        ),
      ),
    );
  }

  Future<void> _paginationChangedEvent(
    PaginationChangedEvent event,
    Emitter<BlocState> emit,
  ) async {
    _limit = event.limit;

    await _search(
      emit: emit,
      offset: event.offset,
      limit: event.limit,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _searchEvent(
    SearchEvent event,
    Emitter<BlocState> emit,
  ) async {
    _searchTerm = event.searchTerm;
    _sortField = event.sortField;
    _sortDirection = event.sortDirection;
    _totalRecords = 0;

    await _search(
      emit: emit,
      offset: 0,
      limit: _limit,
      searchTerm: event.searchTerm,
      sortField: event.sortField,
      sortDirection: event.sortDirection,
    );
  }

  Future<void> _search({
    required Emitter<BlocState> emit,
    required int offset,
    required int limit,
    required String? searchTerm,
    required InventorySortFieldEnum? sortField,
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

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await inventoryDataSource.search(
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
            items: results.items,
          ),
        );
      },
    );
  }
}
