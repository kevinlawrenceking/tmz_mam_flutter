part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCollectionEvent extends BlocEvent {
  final String collectionID;
  final String assetID;

  AddToCollectionEvent({
    required this.collectionID,
    required this.assetID,
  });

  @override
  List<Object?> get props => [
        collectionID,
        assetID,
      ];
}

class LoadAssetDetailsEvent extends BlocEvent {
  final String assetID;

  LoadAssetDetailsEvent({
    required this.assetID,
  });

  @override
  List<Object?> get props => [assetID];
}

class ReloadAssetDetailsEvent extends BlocEvent {
  final AssetDetailsModel model;

  ReloadAssetDetailsEvent({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class RetrieveAgencyPicklistEvent extends BlocEvent {
  final String searchTerm;

  RetrieveAgencyPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class RetrieveCelebrityPicklistEvent extends BlocEvent {
  final String searchTerm;

  RetrieveCelebrityPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class RetrieveKeywordPicklistEvent extends BlocEvent {
  final String searchTerm;

  RetrieveKeywordPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class SaveMetadataEvent extends BlocEvent {
  final String assetID;
  final String headline;
  final AssetMetadataModel metadata;

  SaveMetadataEvent({
    required this.assetID,
    required this.headline,
    required this.metadata,
  });

  @override
  List<Object?> get props => [
        assetID,
        headline,
        metadata,
      ];
}
