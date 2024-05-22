part of 'collection_bloc.dart';

@immutable
abstract class CollectionBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CollectionBlocState {}

class CollectionLoadedState extends CollectionBlocState {
  final CollectionModel model;

  CollectionLoadedState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class CollectionLoadingState extends CollectionBlocState {}

class LoadCollectionFailureState extends CollectionBlocState {
  final Failure failure;

  LoadCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}
