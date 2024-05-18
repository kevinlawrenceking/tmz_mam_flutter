part of 'assets_bloc.dart';

@immutable
abstract class AssetsBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AssetsBlocState {}

class AddAssetsToCollectionFailureState extends AssetsBlocState {
  final Failure failure;

  AddAssetsToCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AddAssetsToCollectionSuccessState extends AssetsBlocState {
  final String _stateID;

  AddAssetsToCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class DeleteAssetFailureState extends AssetsBlocState {
  final Failure failure;

  DeleteAssetFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class DeleteAssetSuccessState extends AssetsBlocState {}

class MoveAssetsToCollectionFailureState extends AssetsBlocState {
  final Failure failure;

  MoveAssetsToCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class MoveAssetsToCollectionSuccessState extends AssetsBlocState {
  final String _stateID;

  MoveAssetsToCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class PaginationChangedState extends AssetsBlocState {
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

class RemoveAssetsFromCollectionFailureState extends AssetsBlocState {
  final Failure failure;

  RemoveAssetsFromCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RemoveAssetsFromCollectionSuccessState extends AssetsBlocState {
  final String _stateID;

  RemoveAssetsFromCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchFailureState extends AssetsBlocState {
  final Failure failure;

  SearchFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class SearchResultsLoadedState extends AssetsBlocState {
  final String _stateID;
  final List<AssetDetailsModel> assets;

  SearchResultsLoadedState({
    required this.assets,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SearchResultsLoadingState extends AssetsBlocState {}
