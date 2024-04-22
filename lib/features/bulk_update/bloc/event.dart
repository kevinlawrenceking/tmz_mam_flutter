part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
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
  final List<String> assetIDs;
  final List<IAssetMetadataFieldValue> values;

  SaveMetadataEvent({
    required this.assetIDs,
    required this.values,
  });

  @override
  List<Object?> get props => [
        assetIDs,
        values,
      ];
}
