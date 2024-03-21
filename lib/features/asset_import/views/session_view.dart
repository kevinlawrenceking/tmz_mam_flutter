import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/asset_import_session.dart';
import 'package:tmz_damz/features/asset_import/bloc/file_bloc.dart';
import 'package:tmz_damz/features/asset_import/bloc/session_bloc.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_upload_view_model.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_view_model.dart';
import 'package:tmz_damz/features/asset_import/widgets/session_file.dart';
import 'package:tmz_damz/features/asset_import/widgets/session_file_form.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:tmz_damz/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:uuid/uuid.dart';

@RoutePage(name: 'AssetImportSessionRoute')
class SessionView extends StatefulWidget {
  final String sessionID;

  const SessionView({
    super.key,
    @PathParam('sessionID') required this.sessionID,
  });

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  late DropzoneViewController _dropController;
  final _fileFormControllers = <String, SessionFileFormController>{};

  @override
  void dispose() {
    for (var i = 0; i < _fileFormControllers.length; i++) {
      _fileFormControllers.entries.elementAt(i).value.dispose();
    }

    _fileFormControllers.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: BlocProvider<SessionBloc>(
        create: (context) {
          final bloc = GetIt.instance<SessionBloc>();

          bloc.add(
            GetSessionDetailsEvent(
              sessionID: widget.sessionID,
            ),
          );

          return bloc;
        },
        child: BlocListener<SessionBloc, SessionBlocState>(
          listenWhen: (_, state) =>
              state is GetSessionDetailsFailureState ||
              state is RemoveSessionFileFailureState ||
              state is SessionFinalizationSuccessState ||
              state is SessionFinalizationFailureState ||
              state is SetFileMetaFailureState,
          listener: (context, state) async {
            if (state is GetSessionDetailsFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.error,
                title: 'Failed to Retrieve Session Details',
                message: state.failure.message,
              );

              await AutoRouter.of(context).navigate(
                const AssetImportRoute(),
              );
            } else if (state is RemoveSessionFileFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.error,
                title: 'Failed to Remove File',
                message: state.failure.message,
              );
            } else if (state is SessionFinalizationSuccessState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.success,
                message: 'Import Complete',
              );

              await AutoRouter.of(context).navigate(
                AssetsSearchRoute(
                  refresh: true,
                ),
              );
            } else if (state is SessionFinalizationFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.error,
                title: 'Failed to Finalize Import',
                message: state.failure.message,
              );
            } else if (state is SetFileMetaFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 5),
                type: ToastTypeEnum.error,
                title: 'Failed to Update Metadata',
                message: state.failure.message,
              );
            }
          },
          child: BlocBuilder<SessionBloc, SessionBlocState>(
            buildWhen: (_, state) =>
                state is SessionDetailsState || state is FinalizingSessionState,
            builder: (context, state) {
              if (state is SessionDetailsState) {
                return _buildSessionDetails(
                  context: context,
                  sessionStatus: state.sessionStatus,
                  files: state.files,
                  uploading: state.uploading,
                );
              } else if (state is FinalizingSessionState) {
                return Stack(
                  children: [
                    _buildSessionDetails(
                      context: context,
                      sessionStatus: AssetImportSessionStatusEnum.processing,
                      files: state.files,
                      uploading: state.uploading,
                    ),
                    Container(
                      color: const Color(0xB0232323),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropHeader() {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x10FFFFFF),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: Center(
        child: Opacity(
          opacity: 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                MdiIcons.trayArrowUp,
                color: theme.textTheme.headlineSmall?.color,
                size: 48.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Drag and drop files anywhere...',
                style: theme.textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropZone({
    required BuildContext context,
  }) {
    return DropzoneView(
      onCreated: (controller) => _dropController = controller,
      onDropMultiple: (files) async {
        if (files == null) {
          return;
        }

        final uploads = <(FileUploadViewModel, dynamic)>[];

        for (var i = 0; i < files.length; i++) {
          final file = FileUploadViewModel(
            sessionID: widget.sessionID,
            uploadID: const Uuid().v4(),
            uploadedAt: DateTime.now().toUtc(),
            fileName: await _dropController.getFilename(files[i]),
            fileSize: await _dropController.getFileSize(files[i]),
            mimeType: await _dropController.getFileMIME(files[i]),
          );

          uploads.add((file, files[i]));

          if (!context.mounted) {
            return;
          }

          BlocProvider.of<SessionBloc>(context).add(
            AddSessionFileEvent(
              file: file,
            ),
          );
        }

        for (var i = 0; i < uploads.length; i++) {
          final data = await _dropController.getFileData(
            uploads[i].$2,
          );

          if (!context.mounted) {
            return;
          }

          BlocProvider.of<SessionBloc>(context).add(
            UploadSessionFileEvent(
              file: uploads[i].$1,
              fileData: data,
            ),
          );
        }
      },
    );
  }

  List<Widget> _buildFileList({
    required BuildContext context,
    required List<FileViewModel> files,
  }) {
    return List.generate(
      files.length,
      (index) {
        final file = files[index];

        return SessionFile(
          file: file,
          onControllerCreated: (controller) {
            if (file.meta != null) {
              controller.setFrom(file.meta!);
            }

            _fileFormControllers[file.fileID] = controller;
          },
          onChange: (meta) {
            BlocProvider.of<SessionBloc>(context).add(
              SetFileMetaEvent(
                sessionID: file.sessionID,
                fileID: file.fileID,
                meta: meta,
              ),
            );
          },
          onRemove: () {
            BlocProvider.of<SessionBloc>(context).add(
              RemoveSessionFileEvent(
                fileID: file.fileID,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSessionDetails({
    required BuildContext context,
    required AssetImportSessionStatusEnum sessionStatus,
    required List<FileViewModel> files,
    required List<FileUploadViewModel> uploading,
  }) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (sessionStatus == AssetImportSessionStatusEnum.$new)
          _buildDropZone(
            context: context,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Import Form',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0x30FFFFFF)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(0x80000000),
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Submit',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onPressed: () {
                      final fileMeta =
                          _fileFormControllers.map((fileID, controller) {
                        final model = controller.getModel();
                        return MapEntry(fileID, model);
                      });

                      if (fileMeta.isEmpty) {
                        return;
                      }

                      BlocProvider.of<SessionBloc>(context).add(
                        FinalizeSessionEvent(
                          sessionID: widget.sessionID,
                          fileMeta: fileMeta,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: MaskedScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sessionStatus == AssetImportSessionStatusEnum.$new)
                      _buildDropHeader(),
                    ..._buildUploadingList(
                      context: context,
                      files: uploading,
                    ),
                    ..._buildFileList(
                      context: context,
                      files: files,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildUploadingList({
    required BuildContext context,
    required List<FileUploadViewModel> files,
  }) {
    return [
      ...List.generate(
        files.length,
        (index) {
          final file = files[index];

          return BlocProvider<FileBloc>(
            key: ValueKey(file.uploadID),
            create: (context) => GetIt.instance<FileBloc>(),
            child: Builder(
              builder: (context) {
                if (file.fileData != null) {
                  BlocProvider.of<FileBloc>(context).add(
                    UploadFileEvent(
                      file: file,
                    ),
                  );
                }

                return BlocListener<FileBloc, FileBlocState>(
                  listenWhen: (_, state) => state is UploadSuccessState,
                  listener: (context, state) {
                    if (state is UploadSuccessState) {
                      BlocProvider.of<SessionBloc>(context).add(
                        SessionFileUploadedEvent(
                          uploadID: state.uploadID,
                          file: state.file,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<FileBloc, FileBlocState>(
                    buildWhen: (_, state) => state is UploadFailureState,
                    builder: (context, state) {
                      var uploadState = SessionFileUploadState.uploading;

                      if (state is UploadFailureState) {
                        uploadState = SessionFileUploadState.error;

                        if (state.failure is ApiError) {
                          switch ((state.failure as ApiError).code) {
                            case 'ERR_ASSET_IMAGE_ALREADY_EXISTS':
                              uploadState = SessionFileUploadState
                                  .assetImageAlreadyExists;
                              break;
                            case 'ERR_INVALID_MIME_TYPE':
                              uploadState =
                                  SessionFileUploadState.invalidFileType;
                              break;
                            case 'ERR_SESSION_FILE_ALREADY_EXISTS':
                              uploadState = SessionFileUploadState
                                  .sessionFileAlreadyExists;
                              break;
                          }
                        }
                      }

                      return SessionFile(
                        uploadFile: file,
                        uploadState: uploadState,
                        onRemove: () {
                          BlocProvider.of<SessionBloc>(context).add(
                            RemoveSessionFileEvent(
                              uploadID: file.uploadID,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      if (files.isNotEmpty)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(),
        ),
    ];
  }
}
