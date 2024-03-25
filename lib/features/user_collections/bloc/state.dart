part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class CollectionsLoadedState extends BlocState {
  final String _stateID;
  final List<CollectionModel> collections;

  CollectionsLoadedState({
    required this.collections,
  }) : _stateID = const Uuid().v4();

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
