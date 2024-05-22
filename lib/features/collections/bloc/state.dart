part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AddCollectionToFavoritesFailureState extends BlocState {
  final Failure failure;

  AddCollectionToFavoritesFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AddCollectionToFavoritesSuccessState extends BlocState {
  final String _stateID;
  final List<String> collectionIDs;

  AddCollectionToFavoritesSuccessState({
    required this.collectionIDs,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class CreateCollectionFailureState extends BlocState {
  final Failure failure;

  CreateCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class CreateCollectionSuccessState extends BlocState {
  final String _stateID;

  CreateCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class DeleteCollectionFailureState extends BlocState {
  final Failure failure;

  DeleteCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class DeleteCollectionSuccessState extends BlocState {
  final String _stateID;
  final List<String> collectionIDs;

  DeleteCollectionSuccessState({
    required this.collectionIDs,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class PaginationChangedState extends BlocState {
  final int offset;
  final int limit;
  final int totalRecords;

  PaginationChangedState({
    required this.offset,
    required this.limit,
    required this.totalRecords,
  });

  @override
  List<Object?> get props => [
        offset,
        limit,
        totalRecords,
      ];
}

class RemoveCollectionFromFavoritesFailureState extends BlocState {
  final Failure failure;

  RemoveCollectionFromFavoritesFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RemoveCollectionFromFavoritesSuccessState extends BlocState {
  final String _stateID;
  final List<String> collectionIDs;

  RemoveCollectionFromFavoritesSuccessState({
    required this.collectionIDs,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SaveCollectionFailureState extends BlocState {
  final Failure failure;

  SaveCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class SaveCollectionSuccessState extends BlocState {
  final String _stateID;

  SaveCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchFailureState extends BlocState {
  final Failure failure;

  SearchFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class SearchResultsLoadedState extends BlocState {
  final String _stateID;
  final List<CollectionModel> collections;

  SearchResultsLoadedState({
    required this.collections,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchResultsLoadingState extends BlocState {}

class SortOptionsChangedState extends BlocState {
  final CollectionSortFieldEnum sortField;
  final SortDirectionEnum sortDirection;

  SortOptionsChangedState({
    required this.sortField,
    required this.sortDirection,
  });

  @override
  List<Object?> get props => [
        sortField,
        sortDirection,
      ];
}
