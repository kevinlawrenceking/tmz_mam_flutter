part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AddAssetsToCollectionFailureState extends BlocState {
  final Failure failure;

  AddAssetsToCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AddAssetsToCollectionSuccessState extends BlocState {
  final String _stateID;

  AddAssetsToCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class MoveAssetsToCollectionFailureState extends BlocState {
  final Failure failure;

  MoveAssetsToCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class MoveAssetsToCollectionSuccessState extends BlocState {
  final String _stateID;

  MoveAssetsToCollectionSuccessState() : _stateID = const Uuid().v4();

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

class RemoveAssetsFromCollectionFailureState extends BlocState {
  final Failure failure;

  RemoveAssetsFromCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RemoveAssetsFromCollectionSuccessState extends BlocState {
  final String _stateID;

  RemoveAssetsFromCollectionSuccessState() : _stateID = const Uuid().v4();

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
  final List<AssetDetailsModel> assets;

  SearchResultsLoadedState({
    required this.assets,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchResultsLoadingState extends BlocState {}
