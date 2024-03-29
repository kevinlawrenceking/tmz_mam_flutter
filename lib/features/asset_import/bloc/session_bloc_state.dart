part of 'session_bloc.dart';

@immutable
abstract class SessionBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends SessionBlocState {}

class GetSessionDetailsFailureState extends SessionBlocState {
  final Failure failure;

  GetSessionDetailsFailureState({
    required this.failure,
  });

  @override
  List<Object?> get props => [
        failure,
      ];
}

class FinalizingSessionState extends SessionBlocState {
  final String _stateID;
  final List<FileViewModel> files;
  final List<FileUploadViewModel> uploading;

  FinalizingSessionState({
    required this.files,
    required this.uploading,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class RemoveSessionFileFailureState extends SessionBlocState {
  final String fileID;
  final Failure failure;

  RemoveSessionFileFailureState({
    required this.fileID,
    required this.failure,
  });

  @override
  List<Object?> get props => [
        fileID,
        failure,
      ];
}

class RemoveSessionFileSuccessState extends SessionBlocState {
  final String fileID;

  RemoveSessionFileSuccessState({
    required this.fileID,
  });

  @override
  List<Object?> get props => [
        fileID,
      ];
}

class SessionDetailsState extends SessionBlocState {
  final String _stateID;
  final AssetImportSessionStatusEnum sessionStatus;
  final List<FileViewModel> files;
  final List<FileUploadViewModel> uploading;

  SessionDetailsState({
    required this.sessionStatus,
    required this.files,
    required this.uploading,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SessionFinalizationFailureState extends SessionBlocState {
  final Failure failure;

  SessionFinalizationFailureState({
    required this.failure,
  });

  @override
  List<Object?> get props => [
        failure,
      ];
}

class SessionFinalizationSuccessState extends SessionBlocState {}

class SessionInitializationFailureState extends SessionBlocState {
  final Failure failure;

  SessionInitializationFailureState({
    required this.failure,
  });

  @override
  List<Object?> get props => [
        failure,
      ];
}

class SessionInitializedState extends SessionBlocState {
  final String sessionID;

  SessionInitializedState({
    required this.sessionID,
  });

  @override
  List<Object?> get props => [
        sessionID,
      ];
}

class SetFileMetaFailureState extends SessionBlocState {
  final String _stateID;
  final Failure failure;

  SetFileMetaFailureState({
    required this.failure,
  }) : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class SetFileMetaSuccessState extends SessionBlocState {
  final AssetImportSessionFileMetaModel meta;

  SetFileMetaSuccessState({
    required this.meta,
  });

  @override
  List<Object?> get props => [
        meta,
      ];
}
