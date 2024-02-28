part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class InventoryDetailsFailureState extends BlocState {
  final Failure failure;

  InventoryDetailsFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class InventoryDetailsLoadedState extends BlocState {
  final InventoryDetailsModel model;

  InventoryDetailsLoadedState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class InventoryDetailsLoadingState extends BlocState {}

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

class SearchFailureState extends BlocState {
  final Failure failure;

  SearchFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class SearchResultsLoadedState extends BlocState {
  final String _stateID;
  final List<InventoryModel> items;

  SearchResultsLoadedState({
    required this.items,
  }) : _stateID = const Uuid().v1();

  @override
  List<Object?> get props => [_stateID];
}

class SearchResultsLoadingState extends BlocState {}
