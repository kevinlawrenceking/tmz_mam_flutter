part of 'metadata_bloc.dart';

@immutable
abstract class MetadataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RetrieveAgencyPicklistEvent extends MetadataBlocEvent {
  final String searchTerm;

  RetrieveAgencyPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class RetrieveCelebrityPicklistEvent extends MetadataBlocEvent {
  final String searchTerm;

  RetrieveCelebrityPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class RetrieveKeywordPicklistEvent extends MetadataBlocEvent {
  final String searchTerm;

  RetrieveKeywordPicklistEvent({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}
