part of 'file_bloc.dart';

@immutable
abstract class FileBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends FileBlocState {}

class UploadFailureState extends FileBlocState {
  final FileUploadViewModel file;
  final Failure failure;

  UploadFailureState({
    required this.file,
    required this.failure,
  });

  @override
  List<Object?> get props => [
        file,
        failure,
      ];
}

class UploadSuccessState extends FileBlocState {
  final String uploadID;
  final FileViewModel file;

  UploadSuccessState({
    required this.uploadID,
    required this.file,
  });

  @override
  List<Object?> get props => [
        uploadID,
        file,
      ];
}
