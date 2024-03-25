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

class SearchEvent extends BlocEvent {
  final String? searchTerm;
  final AssetSortFieldEnum? sortField;
  final SortDirectionEnum? sortDirection;

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
