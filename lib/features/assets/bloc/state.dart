part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AssetDetailsFailureState extends BlocState {
  final Failure failure;

  AssetDetailsFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AssetDetailsLoadedState extends BlocState {
  final AssetDetailsModel model;

  AssetDetailsLoadedState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class AssetDetailsLoadingState extends BlocState {}

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
  final List<AssetDetailsModel> assets;

  SearchResultsLoadedState({
    required this.assets,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchResultsLoadingState extends BlocState {}
