part of 'collection_bloc.dart';

@immutable
abstract class CollectionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCollectionEvent extends CollectionBlocEvent {
  final String collectionID;

  LoadCollectionEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [collectionID];
}
