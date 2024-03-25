part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCollectionsEvent extends BlocEvent {}

class RemoveCollectionEvent extends BlocEvent {
  final String collectionID;

  RemoveCollectionEvent({
    required this.collectionID,
  });

  @override
  List<Object?> get props => [collectionID];
}
