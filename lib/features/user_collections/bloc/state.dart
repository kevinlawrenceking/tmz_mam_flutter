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

  AddCollectionToFavoritesSuccessState() : _stateID = const Uuid().v4();

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

class CollectionsLoadedState extends BlocState {
  final String _stateID;
  final List<CollectionModel> collections;

  CollectionsLoadedState(this.collections) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class CollectionsLoadingState extends BlocState {}

class LoadCollectionsFailureState extends BlocState {
  final Failure failure;

  LoadCollectionsFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RemoveCollectionFromFavoritesFailureState extends BlocState {
  final Failure failure;

  RemoveCollectionFromFavoritesFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RemoveCollectionFromFavoritesSuccessState extends BlocState {
  final String _stateID;

  RemoveCollectionFromFavoritesSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}
