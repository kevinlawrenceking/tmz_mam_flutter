part of 'assets_bloc.dart';

@immutable
abstract class AssetsBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAssetsToCollectionEvent extends AssetsBlocEvent {
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

class DeleteAssetEvent extends AssetsBlocEvent {
  final List<String> assetIDs;

  DeleteAssetEvent({
    required this.assetIDs,
  });

  @override
  List<Object?> get props => [assetIDs];
}

class MoveAssetsToCollectionEvent extends AssetsBlocEvent {
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

class PaginationChangedEvent extends AssetsBlocEvent {
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

class RefreshEvent extends AssetsBlocEvent {}

class ReloadCurrentPageEvent extends AssetsBlocEvent {}

class RemoveAssetsFromCollectionEvent extends AssetsBlocEvent {
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

class SearchAdvancedEvent extends AssetsBlocEvent {
  final AssetSearchDataModel searchData;

  SearchAdvancedEvent({
    required this.searchData,
  });

  @override
  List<Object?> get props => [
        searchData,
      ];
}

class SearchSimpleEvent extends AssetsBlocEvent {
  final String? searchTerm;
  final AssetSortFieldEnum sortField;
  final SortDirectionEnum sortDirection;

  SearchSimpleEvent({
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

class SendAssetsToEvent extends AssetsBlocEvent {
  final List<String> assetIDs;
  final String sendToID;

  SendAssetsToEvent({
    required this.assetIDs,
    required this.sendToID,
  });

  @override
  List<Object?> get props => [
        assetIDs,
        sendToID,
      ];
}

class SetCurrentCollectionEvent extends AssetsBlocEvent {
  final String? collectionID;

  SetCurrentCollectionEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [
        collectionID,
      ];
}
