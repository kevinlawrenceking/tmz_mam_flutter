import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/models/collection_sort_field_enum.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/data/sources/user_collection.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'event.dart';
part 'state.dart';

class CollectionsBloc extends Bloc<BlocEvent, BlocState> {
  final ICollectionDataSource collectionDataSource;
  final IUserCollectionDataSource userCollectionDataSource;

  CollectionsBloc({
    required this.collectionDataSource,
    required this.userCollectionDataSource,
  }) : super(InitialState()) {
    on<AddCollectionToFavoritesEvent>(_addCollectionToFavoritesEvent);
    on<CreateCollectionEvent>(_createCollectionEvent);
    on<DeleteCollectionEvent>(_deleteCollectionEvent);
    on<PaginationChangedEvent>(_paginationChangedEvent);
    on<ReloadCurrentPageEvent>(_reloadCurrentPageEvent);
    on<RemoveCollectionFromFavoritesEvent>(_removeCollectionFromFavoritesEvent);
    on<SaveCollectionEvent>(_saveCollectionEvent);
    on<SearchEvent>(_searchEvent);
  }

  var _offset = 0;
  var _limit = 100;
  String? _searchTerm;
  CollectionSortFieldEnum _sortField = CollectionSortFieldEnum.updatedAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;

  var _totalRecords = 0;
  var _collections = <CollectionModel>[];

  Future<void> _addCollectionToFavoritesEvent(
    AddCollectionToFavoritesEvent event,
    Emitter<BlocState> emit,
  ) async {
    final failed = <String>[];
    final succeeded = <String>[];

    for (var i = 0; i < event.collectionIDs.length; i++) {
      final collectionID = event.collectionIDs[i];

      final result = await userCollectionDataSource.addCollection(
        collectionID: collectionID,
      );

      result.fold(
        (failure) {
          failed.add(collectionID);

          emit(AddCollectionToFavoritesFailureState(failure));
        },
        (_) => succeeded.add(collectionID),
      );
    }

    if (succeeded.isNotEmpty) {
      _collections = _collections.map((_) {
        return _.copyWith(
          favorited: succeeded.contains(_.id) ? true : null,
        );
      }).toList();

      if (failed.isEmpty) {
        emit(
          AddCollectionToFavoritesSuccessState(
            collectionIDs: succeeded,
          ),
        );
      }

      emit(
        SearchResultsLoadedState(
          collections: _collections,
        ),
      );
    }
  }

  Future<void> _createCollectionEvent(
    CreateCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await collectionDataSource.createCollection(
      isPrivate: event.isPrivate,
      autoClear: event.autoClear,
      name: event.name,
      description: event.description,
    );

    result.fold(
      (failure) => emit(CreateCollectionFailureState(failure)),
      (_) => emit(CreateCollectionSuccessState()),
    );

    final collection = result.fold(
      (failure) {
        emit(CreateCollectionFailureState(failure));
        return null;
      },
      (collection) {
        emit(CreateCollectionSuccessState());
        return collection;
      },
    );

    if (collection == null) {
      return;
    }

    if (event.addToFavorites) {
      final addResult = await userCollectionDataSource.addCollection(
        collectionID: collection.id,
      );

      addResult.fold(
        (failure) => emit(AddCollectionToFavoritesFailureState(failure)),
        (_) {},
      );
    }

    _offset = 0;
    _sortField = CollectionSortFieldEnum.createdAt;
    _sortDirection = SortDirectionEnum.descending;
    _totalRecords = 0;

    emit(
      SortOptionsChangedState(
        sortField: _sortField,
        sortDirection: _sortDirection,
      ),
    );

    await _getCollectionList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _deleteCollectionEvent(
    DeleteCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final failed = <String>[];
    final succeeded = <String>[];

    for (var i = 0; i < event.collectionIDs.length; i++) {
      final collectionID = event.collectionIDs[i];

      final result = await collectionDataSource.deleteCollection(
        collectionID: collectionID,
      );

      result.fold(
        (failure) {
          failed.add(collectionID);

          emit(DeleteCollectionFailureState(failure));
        },
        (_) => succeeded.add(collectionID),
      );
    }

    if (succeeded.isNotEmpty) {
      _collections = _collections
          .whereNot(
            (_) => succeeded.contains(_.id),
          )
          .toList();

      if (failed.isEmpty) {
        emit(
          DeleteCollectionSuccessState(
            collectionIDs: succeeded,
          ),
        );
      }

      emit(
        SearchResultsLoadedState(
          collections: _collections,
        ),
      );
    }
  }

  Future<void> _paginationChangedEvent(
    PaginationChangedEvent event,
    Emitter<BlocState> emit,
  ) async {
    _offset = event.offset;
    _limit = event.limit;

    await _getCollectionList(
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
    await _getCollectionList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }

  Future<void> _removeCollectionFromFavoritesEvent(
    RemoveCollectionFromFavoritesEvent event,
    Emitter<BlocState> emit,
  ) async {
    final failed = <String>[];
    final succeeded = <String>[];

    for (var i = 0; i < event.collectionIDs.length; i++) {
      final collectionID = event.collectionIDs[i];

      final result = await userCollectionDataSource.removeCollection(
        collectionID: collectionID,
      );

      result.fold(
        (failure) {
          failed.add(collectionID);

          emit(RemoveCollectionFromFavoritesFailureState(failure));
        },
        (_) => succeeded.add(collectionID),
      );
    }

    if (succeeded.isNotEmpty) {
      _collections = _collections.map((_) {
        return _.copyWith(
          favorited: succeeded.contains(_.id) ? false : null,
        );
      }).toList();

      if (failed.isEmpty) {
        emit(
          RemoveCollectionFromFavoritesSuccessState(
            collectionIDs: succeeded,
          ),
        );
      }

      emit(
        SearchResultsLoadedState(
          collections: _collections,
        ),
      );
    }
  }

  Future<void> _saveCollectionEvent(
    SaveCollectionEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await collectionDataSource.updateCollection(
      collectionID: event.collectionID,
      isPrivate: event.isPrivate,
      autoClear: event.autoClear,
      name: event.name,
      description: event.description,
    );

    result.fold(
      (failure) => emit(SaveCollectionFailureState(failure)),
      (collection) {
        _collections = _collections.map((_) {
          if (_.id == event.collectionID) {
            return _.copyWith(
              isPrivate: collection.isPrivate,
              autoClear: collection.autoClear,
              name: collection.name,
              description: collection.description,
            );
          } else {
            return _.copyWith();
          }
        }).toList();

        emit(SaveCollectionSuccessState());

        emit(
          SearchResultsLoadedState(
            collections: _collections,
          ),
        );
      },
    );
  }

  Future<void> _getCollectionList({
    required Emitter<BlocState> emit,
    required int offset,
    required int limit,
    required String? searchTerm,
    required CollectionSortFieldEnum? sortField,
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

    final result = await collectionDataSource.getCollectionList(
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
        _collections = results.collections;

        emit(
          PaginationChangedState(
            offset: offset,
            limit: limit,
            totalRecords: results.totalRecords,
          ),
        );

        emit(
          SearchResultsLoadedState(
            collections: results.collections,
          ),
        );
      },
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

    emit(
      SortOptionsChangedState(
        sortField: _sortField,
        sortDirection: _sortDirection,
      ),
    );

    await _getCollectionList(
      emit: emit,
      offset: _offset,
      limit: _limit,
      searchTerm: _searchTerm,
      sortField: _sortField,
      sortDirection: _sortDirection,
    );
  }
}
