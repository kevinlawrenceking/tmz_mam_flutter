part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AgencyPicklistState extends BlocState {
  final String _stateID;
  final List<PicklistAgencyModel> picklist;

  AgencyPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class CelebrityPicklistState extends BlocState {
  final String _stateID;
  final List<PicklistCelebrityModel> picklist;

  CelebrityPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class KeywordPicklistState extends BlocState {
  final String _stateID;
  final List<PicklistKeywordModel> picklist;

  KeywordPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class UpdateMetadataCompleteState extends BlocState {}

class UpdateMetadataFailureState extends BlocState {
  final Failure failure;

  UpdateMetadataFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class UpdateMetadataProgressState extends BlocState {
  final double progress;

  UpdateMetadataProgressState({
    required this.progress,
  });

  @override
  List<Object?> get props => [progress];
}

class UpdatingMetadataState extends BlocState {}
