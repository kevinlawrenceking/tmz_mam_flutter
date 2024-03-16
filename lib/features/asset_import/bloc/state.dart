part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class GetSessionDetailsFailureState extends BlocState {}

class RemoveSessionFileFailureState extends BlocState {
  final String sessionID;
  final String fileID;
  final Failure failure;

  RemoveSessionFileFailureState({
    required this.sessionID,
    required this.fileID,
    required this.failure,
  });

  @override
  List<Object?> get props => [
        sessionID,
        fileID,
        failure,
      ];
}

class RemovingSessionFileState extends BlocState {
  final String sessionID;
  final String fileID;

  RemovingSessionFileState({
    required this.sessionID,
    required this.fileID,
  });

  @override
  List<Object?> get props => [
        sessionID,
        fileID,
      ];
}

class RemoveSessionFileSuccessState extends BlocState {
  final String sessionID;
  final String fileID;

  RemoveSessionFileSuccessState({
    required this.sessionID,
    required this.fileID,
  });

  @override
  List<Object?> get props => [
        sessionID,
        fileID,
      ];
}

class SessionDetailsState extends BlocState {
  final AssetImportSessionDetailsModel session;

  SessionDetailsState(this.session);

  @override
  List<Object?> get props => [session];
}

class UploadingSessionFileState extends BlocState {
  final String sessionID;
  final String uploadID;
  final String fileName;

  UploadingSessionFileState({
    required this.sessionID,
    required this.uploadID,
    required this.fileName,
  });

  @override
  List<Object?> get props => [
        sessionID,
        uploadID,
        fileName,
      ];
}

class UploadSessionFileFailureState extends BlocState {
  final String sessionID;
  final String uploadID;
  final Failure failure;

  UploadSessionFileFailureState({
    required this.sessionID,
    required this.uploadID,
    required this.failure,
  });

  @override
  List<Object?> get props => [
        sessionID,
        uploadID,
        failure,
      ];
}

class UploadSessionFileSuccessState extends BlocState {
  final String sessionID;
  final String uploadID;
  final AssetImportSessionFileModel file;

  UploadSessionFileSuccessState({
    required this.sessionID,
    required this.uploadID,
    required this.file,
  });

  @override
  List<Object?> get props => [
        sessionID,
        uploadID,
        file,
      ];
}
