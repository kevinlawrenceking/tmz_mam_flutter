import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_import_session.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/sources/asset_import_session.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

part 'event.dart';
part 'state.dart';

class AssetImportBloc extends Bloc<BlocEvent, BlocState> {
  final IAssetImportSessionDataSource assetImportSessionDataSource;

  AssetImportBloc({
    required this.assetImportSessionDataSource,
  }) : super(InitialState()) {
    on<GetSessionDetailsEvent>(_getSessionDetailsEvent);
    on<RemoveSessionFileEvent>(_removeSessionFileEvent);
    on<UploadSessionFileEvent>(_uploadSessionFileEvent);
  }

  Future<void> _getSessionDetailsEvent(
    GetSessionDetailsEvent event,
    Emitter<BlocState> emit,
  ) async {
    final result = await assetImportSessionDataSource.getSessionDetails(
      sessionID: event.sessionID,
    );

    result.fold(
      (failure) => emit(GetSessionDetailsFailureState()),
      (sessionDetails) => emit(SessionDetailsState(sessionDetails)),
    );
  }

  Future<void> _removeSessionFileEvent(
    RemoveSessionFileEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(
      RemovingSessionFileState(
        sessionID: event.sessionID,
        fileID: event.fileID,
      ),
    );

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetImportSessionDataSource.removeSessionFile(
      sessionID: event.sessionID,
      fileID: event.fileID,
    );

    result.fold(
      (failure) => emit(
        RemoveSessionFileFailureState(
          sessionID: event.sessionID,
          fileID: event.fileID,
          failure: failure,
        ),
      ),
      (_) => emit(
        RemoveSessionFileSuccessState(
          sessionID: event.sessionID,
          fileID: event.fileID,
        ),
      ),
    );
  }

  Future<void> _uploadSessionFileEvent(
    UploadSessionFileEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(
      UploadingSessionFileState(
        sessionID: event.sessionID,
        uploadID: event.uploadID,
        fileName: event.fileName,
      ),
    );

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await assetImportSessionDataSource.uploadSessionFile(
      sessionID: event.sessionID,
      fileName: event.fileName,
      fileStream: event.fileStream,
      fileSize: event.fileSize,
    );

    result.fold(
      (failure) => emit(
        UploadSessionFileFailureState(
          sessionID: event.sessionID,
          uploadID: event.uploadID,
          failure: failure,
        ),
      ),
      (file) => emit(
        UploadSessionFileSuccessState(
          sessionID: event.sessionID,
          uploadID: event.uploadID,
          file: file,
        ),
      ),
    );
  }
}
