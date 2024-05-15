part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAssetsToCollectionEvent extends BlocEvent {
  final String collectionID;
  final List<String> assetIDs;

  AddAssetsToCollectionEvent({
    required this.collectionID,
    required this.assetIDs,
  });

  @override
  List<Object?> get props => [
        collectionID,
        assetIDs,
      ];
}

class DeleteAssetEvent extends BlocEvent {
  final List<String> assetIDs;

  DeleteAssetEvent({
    required this.assetIDs,
  });

  @override
  List<Object?> get props => [assetIDs];
}

class MoveAssetsToCollectionEvent extends BlocEvent {
  final String sourceCollectionID;
  final String targetCollectionID;
  final List<String> assetIDs;

  MoveAssetsToCollectionEvent({
    required this.sourceCollectionID,
    required this.targetCollectionID,
    required this.assetIDs,
  });

  @override
  List<Object?> get props => [
        sourceCollectionID,
        targetCollectionID,
        assetIDs,
      ];
}

class PaginationChangedEvent extends BlocEvent {
  final int offset;
  final int limit;

  PaginationChangedEvent({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        offset,
        limit,
      ];
}

class RefreshEvent extends BlocEvent {}

class ReloadCurrentPageEvent extends BlocEvent {}

class RemoveAssetsFromCollectionEvent extends BlocEvent {
  final String collectionID;
  final List<String> assetIDs;

  RemoveAssetsFromCollectionEvent({
    required this.collectionID,
    required this.assetIDs,
  });

  @override
  List<Object?> get props => [
        collectionID,
        assetIDs,
      ];
}

class SearchEvent extends BlocEvent {
  final String? searchTerm;
  final AssetSortFieldEnum sortField;
  final SortDirectionEnum sortDirection;

  SearchEvent({
    this.searchTerm,
    required this.sortField,
    required this.sortDirection,
  });

  @override
  List<Object?> get props => [
        searchTerm,
        sortField,
        sortDirection,
      ];
}

class SetCurrentCollectionEvent extends BlocEvent {
  final String? collectionID;

  SetCurrentCollectionEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [
        collectionID,
      ];
}
