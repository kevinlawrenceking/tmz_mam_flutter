part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAssetDetailsEvent extends BlocEvent {
  final String assetID;

  LoadAssetDetailsEvent({
    required this.assetID,
  });

  @override
  List<Object?> get props => [assetID];
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

class SearchEvent extends BlocEvent {
  final String? searchTerm;
  final AssetSortFieldEnum? sortField;
  final SortDirectionEnum? sortDirection;

  SearchEvent({
    required this.searchTerm,
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
