part of 'bloc.dart';

@immutable
abstract class MetadataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends MetadataBlocState {}

class AgencyPicklistState extends MetadataBlocState {
  final String _stateID;
  final List<PicklistAgencyModel> picklist;

  AgencyPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class CelebrityPicklistState extends MetadataBlocState {
  final String _stateID;
  final List<PicklistCelebrityModel> picklist;

  CelebrityPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class KeywordPicklistState extends MetadataBlocState {
  final String _stateID;
  final List<PicklistKeywordModel> picklist;

  KeywordPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class UserPicklistState extends MetadataBlocState {
  final String _stateID;
  final List<UserMetaModel> picklist;

  UserPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}
