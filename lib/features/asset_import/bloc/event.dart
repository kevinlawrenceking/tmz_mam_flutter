part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSessionDetailsEvent extends BlocEvent {
  final String sessionID;

  GetSessionDetailsEvent(this.sessionID);

  @override
  List<Object?> get props => [sessionID];
}

class RemoveSessionFileEvent extends BlocEvent {
  final String sessionID;
  final String fileID;

  RemoveSessionFileEvent({
    required this.sessionID,
    required this.fileID,
  });

  @override
  List<Object?> get props => [
        sessionID,
        fileID,
      ];
}

class UploadSessionFileEvent extends BlocEvent {
  final String sessionID;
  final String uploadID;
  final String fileName;
  final Stream<List<int>> fileStream;
  final int fileSize;

  UploadSessionFileEvent({
    required this.sessionID,
    required this.uploadID,
    required this.fileName,
    required this.fileStream,
    required this.fileSize,
  });

  @override
  List<Object?> get props => [
        sessionID,
        uploadID,
        fileName,
        fileStream,
        fileSize,
      ];
}
