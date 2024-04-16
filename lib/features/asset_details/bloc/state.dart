part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class AddToCollectionFailureState extends BlocState {
  final Failure failure;

  AddToCollectionFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AddToCollectionSuccessState extends BlocState {
  final String _stateID;

  AddToCollectionSuccessState() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class AgencyPicklistState extends BlocState {
  final String _stateID;
  final List<PicklistAgencyModel> picklist;

  AgencyPicklistState({
    required this.picklist,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class AssetDetailsFailureState extends BlocState {
  final Failure failure;

  AssetDetailsFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AssetDetailsLoadedState extends BlocState {
  final AssetDetailsModel model;

  AssetDetailsLoadedState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}

class AssetDetailsLoadingState extends BlocState {}

class AssetDetailsReloadingState extends BlocState {
  final AssetDetailsModel model;

  AssetDetailsReloadingState({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
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

class MetadataUpdatedState extends BlocState {
  final String headline;
  final AssetMetadataModel metadata;

  MetadataUpdatedState({
    required this.headline,
    required this.metadata,
  });

  @override
  List<Object?> get props => [
        headline,
        metadata,
      ];
}

class UpdateMetadataFailureState extends BlocState {
  final Failure failure;

  UpdateMetadataFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class UpdatingMetadataState extends BlocState {}
