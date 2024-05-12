part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCollectionToFavoritesEvent extends BlocEvent {
  final String collectionID;

  AddCollectionToFavoritesEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [collectionID];
}

class CreateCollectionEvent extends BlocEvent {
  final String name;
  final String description;
  final bool isPrivate;
  final bool autoClear;

  CreateCollectionEvent({
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.autoClear,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        isPrivate,
        autoClear,
      ];
}

class LoadCollectionsEvent extends BlocEvent {}

class RemoveCollectionFromFavoritesEvent extends BlocEvent {
  final String collectionID;

  RemoveCollectionFromFavoritesEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [collectionID];
}
