part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInventoryDetailsEvent extends BlocEvent {
  final int itemID;

  LoadInventoryDetailsEvent({
    required this.itemID,
  });

  @override
  List<Object?> get props => [itemID];
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
  final InventorySortFieldEnum? sortField;
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
