import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/data/models/asset_import_session.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/sources/asset_import_session.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_upload_view_model.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_view_model.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:uuid/uuid.dart';

part 'session_bloc_event.dart';
part 'session_bloc_state.dart';

class SessionBloc extends Bloc<SessionBlocEvent, SessionBlocState> {
  final IAssetImportSessionDataSource assetImportSessionDataSource;

  String? _sessionID;
  AssetImportSessionStatusEnum _sessionStatus =
      AssetImportSessionStatusEnum.unknown;

  List<FileViewModel> _files = [];
  final List<FileUploadViewModel> _uploading = [];

  SessionBloc({
    required this.assetImportSessionDataSource,
  }) : super(InitialState()) {
    on<AddSessionFileEvent>(_addSessionFileEvent);
    on<FinalizeSessionEvent>(_finalizeSessionEvent);
    on<GetSessionDetailsEvent>(_getSessionDetailsEvent);
    on<InitializeSession>(_initializeSession);
    on<RemoveSessionFileEvent>(_removeSessionFileEvent);
    on<SessionFileUploadedEvent>(_sessionFileUploadedEvent);
    on<SetFileMetaEvent>(_setFileMetaEvent);
    on<UploadSessionFileEvent>(_uploadSessionFileEvent);
  }

  Future<void> _addSessionFileEvent(
    AddSessionFileEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    _uploading.insert(0, event.file);

    emit(
      SessionDetailsState(
        sessionStatus: _sessionStatus,
        files: _files,
        uploading: _uploading,
      ),
    );
  }

  Future<void> _finalizeSessionEvent(
    FinalizeSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    emit(
      FinalizingSessionState(
        files: _files,
        uploading: _uploading,
      ),
    );

    final result = await assetImportSessionDataSource.finalizeSession(
      sessionID: event.sessionID,
    );

    result.fold(
      (failure) {
        emit(
          SessionFinalizationFailureState(
            failure: failure,
          ),
        );

        emit(
          SessionDetailsState(
            sessionStatus: _sessionStatus,
            files: _files,
            uploading: _uploading,
          ),
        );
      },
      (details) => emit(SessionFinalizationSuccessState()),
    );
  }

  Future<void> _getSessionDetailsEvent(
    GetSessionDetailsEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    final result = await assetImportSessionDataSource.getSessionDetails(
      sessionID: event.sessionID,
    );

    result.fold(
      (failure) => emit(
        GetSessionDetailsFailureState(
          failure: failure,
        ),
      ),
      (details) {
        _sessionID = details.id;
        _sessionStatus = details.status;

        _files.clear();
        _files.addAll(
          details.files
              .map(
                (_) => FileViewModel.fromAssetImportSessionFileModel(_),
              )
              .sortedByCompare(
                (_) => _.uploadedAt,
                (a, b) => b.compareTo(a), // sort descending
              ),
        );

        _uploading.clear();

        emit(
          SessionDetailsState(
            sessionStatus: _sessionStatus,
            files: _files,
            uploading: _uploading,
          ),
        );
      },
    );
  }

  Future<void> _initializeSession(
    InitializeSession event,
    Emitter<SessionBlocState> emit,
  ) async {
    final result = await assetImportSessionDataSource.getSessionList();

    var sessionID = await result.fold(
      (failure) {
        emit(
          SessionInitializationFailureState(
            failure: failure,
          ),
        );

        return null;
      },
      (sessions) async {
        final activeSession = sessions
            .sortedByCompare(
              (_) => _.createdAt,
              (a, b) => b.compareTo(a), // sort descending
            )
            .firstWhereOrNull(
              (_) => _.status == AssetImportSessionStatusEnum.$new,
            );

        return activeSession?.id;
      },
    );

    if (sessionID == null) {
      final result = await assetImportSessionDataSource.createSession();

      sessionID = result.fold(
        (failure) {
          emit(
            SessionInitializationFailureState(
              failure: failure,
            ),
          );

          return null;
        },
        (session) => session.id,
      );
    }

    if (sessionID != null) {
      emit(
        SessionInitializedState(
          sessionID: sessionID,
        ),
      );
    }
  }

  Future<void> _removeSessionFileEvent(
    RemoveSessionFileEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    if (event.fileID != null) {
      final result = await assetImportSessionDataSource.removeSessionFile(
        sessionID: _sessionID!,
        fileID: event.fileID!,
      );

      result.fold(
        (failure) => emit(
          RemoveSessionFileFailureState(
            fileID: event.fileID!,
            failure: failure,
          ),
        ),
        (_) {
          _files.removeWhere((_) => _.fileID == event.fileID);

          emit(
            RemoveSessionFileSuccessState(
              fileID: event.fileID!,
            ),
          );

          emit(
            SessionDetailsState(
              sessionStatus: _sessionStatus,
              files: _files,
              uploading: _uploading,
            ),
          );
        },
      );
    } else if (event.uploadID != null) {
      _uploading.removeWhere((_) => _.uploadID == event.uploadID);

      emit(
        SessionDetailsState(
          sessionStatus: _sessionStatus,
          files: _files,
          uploading: _uploading,
        ),
      );
    }
  }

  Future<void> _sessionFileUploadedEvent(
    SessionFileUploadedEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    _uploading.removeWhere((_) => _.uploadID == event.uploadID);

    _files.insert(0, event.file);

    _files = _files.sortedByCompare(
      (_) => _.uploadedAt,
      (a, b) => b.compareTo(a), // sort descending
    );

    emit(
      SessionDetailsState(
        sessionStatus: _sessionStatus,
        files: _files,
        uploading: _uploading,
      ),
    );
  }

  Future<void> _setFileMetaEvent(
    SetFileMetaEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    final result = await assetImportSessionDataSource.setSessionFileMeta(
      sessionID: event.sessionID,
      fileID: event.fileID,
      meta: event.meta,
    );

    result.fold(
      (failure) => emit(
        SetFileMetaFailureState(
          failure: failure,
        ),
      ),
      (meta) {
        final index = _files.indexWhere(
          (_) => _.fileID == event.fileID,
        );

        _files[index] = _files[index].copyWith(
          meta: meta,
        );

        emit(
          SetFileMetaSuccessState(
            bulk: event.bulk,
          ),
        );
      },
    );
  }

  Future<void> _uploadSessionFileEvent(
    UploadSessionFileEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    if (_sessionID == null) {
      return;
    }

    final index = _uploading.indexWhere(
      (_) => _.uploadID == event.file.uploadID,
    );

    _uploading[index] = FileUploadViewModel(
      sessionID: _sessionID!,
      uploadID: event.file.uploadID,
      uploadedAt: event.file.uploadedAt,
      fileName: event.file.fileName,
      fileSize: event.file.fileSize,
      fileData: event.fileData,
      mimeType: event.file.mimeType,
    );

    emit(
      SessionDetailsState(
        sessionStatus: _sessionStatus,
        files: _files,
        uploading: _uploading,
      ),
    );
  }
}
