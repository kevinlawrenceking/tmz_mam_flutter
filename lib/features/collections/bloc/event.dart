part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCollectionToFavoritesEvent extends BlocEvent {
  final List<String> collectionIDs;

  AddCollectionToFavoritesEvent({
    required this.collectionIDs,
  });

  @override
  List<Object?> get props => [collectionIDs];
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

class DeleteCollectionEvent extends BlocEvent {
  final List<String> collectionIDs;

  DeleteCollectionEvent({
    required this.collectionIDs,
  });

  @override
  List<Object?> get props => [collectionIDs];
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

class ReloadCurrentPageEvent extends BlocEvent {}

class RemoveCollectionFromFavoritesEvent extends BlocEvent {
  final List<String> collectionIDs;

  RemoveCollectionFromFavoritesEvent({
    required this.collectionIDs,
  });

  @override
  List<Object?> get props => [collectionIDs];
}

class SaveCollectionEvent extends BlocEvent {
  final String collectionID;
  final String name;
  final String description;
  final bool isPrivate;
  final bool autoClear;

  SaveCollectionEvent({
    required this.collectionID,
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.autoClear,
  });

  @override
  List<Object?> get props => [
        collectionID,
        name,
        description,
        isPrivate,
        autoClear,
      ];
}

class SearchEvent extends BlocEvent {
  final String? searchTerm;

  SearchEvent({
    this.searchTerm,
  });

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}
