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
  List<Object?> get props => [
        file,
      ];
}

class FinalizeSessionEvent extends SessionBlocEvent {
  final String sessionID;

  FinalizeSessionEvent({
    required this.sessionID,
  });

  @override
  List<Object?> get props => [
        sessionID,
      ];
}

class GetSessionDetailsEvent extends SessionBlocEvent {
  final String sessionID;

  GetSessionDetailsEvent({
    required this.sessionID,
  });

  @override
  List<Object?> get props => [
        sessionID,
      ];
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
