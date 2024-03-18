part of 'file_bloc.dart';

@immutable
abstract class FileBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadFileEvent extends FileBlocEvent {
  final FileUploadViewModel file;

  UploadFileEvent({
    required this.file,
  });

  @override
  List<Object?> get props => [
        file,
      ];
}
