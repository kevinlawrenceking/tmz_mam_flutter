import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/sources/asset_import_session.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_upload_view_model.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_view_model.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

part 'file_bloc_event.dart';
part 'file_bloc_state.dart';

class FileBloc extends Bloc<FileBlocEvent, FileBlocState> {
  final IAssetImportSessionDataSource assetImportSessionDataSource;

  FileUploadViewModel? _file;

  FileBloc({
    required this.assetImportSessionDataSource,
  }) : super(InitialState()) {
    on<UploadFileEvent>(_uploadFileEvent);
  }

  Future<void> _uploadFileEvent(
    UploadFileEvent event,
    Emitter<FileBlocState> emit,
  ) async {
    if (_file != null) {
      return;
    }

    _file = event.file;

    final result = await assetImportSessionDataSource.uploadSessionFile(
      sessionID: event.file.sessionID,
      fileName: event.file.fileName,
      fileSize: event.file.fileSize,
      fileData: event.file.fileData!,
      mimeType: event.file.mimeType!,
    );

    result.fold(
      (failure) => emit(
        UploadFailureState(
          file: event.file,
          failure: failure,
        ),
      ),
      (file) => emit(
        UploadSuccessState(
          uploadID: event.file.uploadID,
          file: FileViewModel.fromAssetImportSessionFileModel(file),
        ),
      ),
    );
  }
}
