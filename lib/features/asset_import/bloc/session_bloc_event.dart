part of 'session_bloc.dart';

@immutable
abstract class SessionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddSessionFileEvent extends SessionBlocEvent {
  final FileUploadViewModel file;

  AddSessionFileEvent({
    required this.file,
  });

  @override
  List<Object?> get props => [file];
}

class FinalizeSessionEvent extends SessionBlocEvent {
  final String sessionID;
  final Map<String, AssetImportSessionFileMetaModel> fileMeta;

  FinalizeSessionEvent({
    required this.sessionID,
    required this.fileMeta,
  });

  @override
  List<Object?> get props => [
        sessionID,
        fileMeta,
      ];
}

class GetSessionDetailsEvent extends SessionBlocEvent {
  final String sessionID;

  GetSessionDetailsEvent({
    required this.sessionID,
  });

  @override
  List<Object?> get props => [sessionID];
}

class InitializeSession extends SessionBlocEvent {}

class RemoveSessionFileEvent extends SessionBlocEvent {
  final String? fileID;
  final String? uploadID;

  RemoveSessionFileEvent({
    this.fileID,
    this.uploadID,
  });

  @override
  List<Object?> get props => [
        fileID,
        uploadID,
      ];
}

class SessionFileUploadedEvent extends SessionBlocEvent {
  final String uploadID;
  final FileViewModel file;

  SessionFileUploadedEvent({
    required this.uploadID,
    required this.file,
  });

  @override
  List<Object?> get props => [
        uploadID,
        file,
      ];
}

class SetFileMetaEvent extends SessionBlocEvent {
  final bool bulk;
  final String sessionID;
  final String fileID;
  final AssetImportSessionFileMetaModel meta;

  SetFileMetaEvent({
    required this.bulk,
    required this.sessionID,
    required this.fileID,
    required this.meta,
  });

  @override
  List<Object?> get props => [
        bulk,
        sessionID,
        fileID,
        meta,
      ];
}

class UploadSessionFileEvent extends SessionBlocEvent {
  final FileUploadViewModel file;
  final Uint8List fileData;

  UploadSessionFileEvent({
    required this.file,
    required this.fileData,
  });

  @override
  List<Object?> get props => [
        file,
        fileData,
      ];
}
