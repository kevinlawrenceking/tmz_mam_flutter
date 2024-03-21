import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_upload_view_model.dart';
import 'package:tmz_damz/features/asset_import/view_models/file_view_model.dart';
import 'package:tmz_damz/features/asset_import/widgets/session_file_form.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/utils/config.dart';

enum SessionFileUploadState {
  uploading,
  error,
  invalidFileType,
  assetImageAlreadyExists,
  sessionFileAlreadyExists,
}

class SessionFile extends StatefulWidget {
  final FileViewModel? file;
  final FileUploadViewModel? uploadFile;
  final SessionFileUploadState uploadState;
  final void Function(SessionFileFormController controller)?
      onControllerCreated;
  final void Function(AssetImportSessionFileMetaModel meta)? onChange;
  final void Function() onRemove;

  const SessionFile({
    super.key,
    this.file,
    this.uploadFile,
    this.uploadState = SessionFileUploadState.uploading,
    this.onControllerCreated,
    this.onChange,
    required this.onRemove,
  });

  @override
  State<SessionFile> createState() => _SessionFileState();
}

class _SessionFileState extends State<SessionFile> {
  late SessionFileFormController _controller;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = SessionFileFormController();

    widget.onControllerCreated?.call(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Opacity(
        opacity: (widget.file != null) ? 1.0 : 0.4,
        child: (widget.file != null)
            ? ExpansionTile(
                backgroundColor: const Color(0x10FFFFFF),
                collapsedBackgroundColor: const Color(0x10FFFFFF),
                clipBehavior: Clip.antiAlias,
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                tilePadding: const EdgeInsets.only(
                  left: 20.0,
                  top: 10.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                title: _buildContent(context),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SessionFileForm(
                      controller: _controller,
                      onChange: widget.onChange,
                    ),
                  ),
                ],
              )
            : DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: const Color(0x10FFFFFF),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildContent(context),
                ),
              ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    final uploadedAt = widget.file?.uploadedAt ?? widget.uploadFile?.uploadedAt;

    return Row(
      children: [
        _buildThumbnail(),
        const SizedBox(width: 50.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.file?.fileName ?? widget.uploadFile?.fileName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: theme.textTheme.titleSmall,
              ),
              _buildFileSize(
                theme: theme,
                fileSize: widget.file?.fileSize ??
                    Int64(widget.uploadFile?.fileSize ?? 0),
              ),
              _buildUploadedAt(
                theme: theme,
                uploadedAt: uploadedAt,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        if (widget.file != null) ...[
          _buildFileStatus(
            theme: theme,
            status: widget.file!.status,
          ),
          const SizedBox(width: 30.0),
          if ((widget.file!.status !=
                  AssetImportSessionFileStatusEnum.imported) &&
              (widget.file!.status !=
                  AssetImportSessionFileStatusEnum.processing))
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color(0xDEFFFFFF),
                size: 22,
              ),
              onPressed: widget.onRemove,
            ),
        ],
        if (widget.uploadFile != null) ...[
          _buildUploadState(
            theme: theme,
            state: widget.uploadState,
          ),
          const SizedBox(width: 30.0),
          if (widget.uploadState != SessionFileUploadState.uploading)
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color(0xDEFFFFFF),
                size: 22,
              ),
              onPressed: widget.onRemove,
            ),
        ],
      ],
    );
  }

  Widget _buildFileSize({
    required ThemeData theme,
    required Int64 fileSize,
  }) {
    return Opacity(
      opacity: 0.4,
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        text: TextSpan(
          style: theme.textTheme.bodySmall,
          children: [
            const TextSpan(
              text: 'Size: ',
            ),
            TextSpan(
              text: (fileSize.toDouble() /
                      ((fileSize >= 1000000) ? 1000000.0 : 1000.0))
                  .ceil()
                  .toString(),
            ),
            TextSpan(
              text: (fileSize >= 1000000) ? ' MB' : ' kb',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileStatus({
    required ThemeData theme,
    required AssetImportSessionFileStatusEnum status,
  }) {
    if (status == AssetImportSessionFileStatusEnum.processing) {
      return const SizedBox(
        height: 32.0,
        width: 32.0,
        child: CircularProgressIndicator(),
      );
    } else {
      String label;
      Color? color;

      switch (status) {
        case AssetImportSessionFileStatusEnum.error:
          label = 'ERROR';
          color = Colors.red;
          break;
        case AssetImportSessionFileStatusEnum.imported:
          label = 'IMPORTED';
          color = Colors.green;
          break;
        case AssetImportSessionFileStatusEnum.ready:
          label = 'READY';
          color = Colors.blue;
          break;
        default:
          label = '';
          break;
      }

      return Text(
        label,
        maxLines: 1,
        softWrap: false,
        style: theme.textTheme.titleSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  Widget _buildThumbnail() {
    Widget content;

    if (widget.file != null) {
      if (widget.file!.status == AssetImportSessionFileStatusEnum.error) {
        content = Center(
          child: Icon(
            MdiIcons.alert,
            color: const Color(0xFF303030),
            size: 40,
          ),
        );
      } else {
        content = FileThumbnail(
          url: '${GetIt.instance<Config>().apiBaseUrl}'
              '/asset/import/session/${widget.file!.sessionID}'
              '/file/${widget.file!.fileID}'
              '/thumbnail',
        );
      }
    } else {
      if (widget.uploadState == SessionFileUploadState.uploading) {
        content = const Center(
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        content = Center(
          child: Icon(
            MdiIcons.alert,
            color: const Color(0xFF303030),
            size: 40,
          ),
        );
      }
    }

    return SizedBox(
      height: 120.0,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: content,
        ),
      ),
    );
  }

  Widget _buildUploadedAt({
    required ThemeData theme,
    required DateTime? uploadedAt,
  }) {
    return Opacity(
      opacity: 0.4,
      child: Timeago(
        date: uploadedAt ?? DateTime(1),
        builder: (context, value) {
          return RichText(
            text: TextSpan(
              style: theme.textTheme.bodySmall,
              children: [
                const TextSpan(
                  text: 'Uploaded: ',
                ),
                TextSpan(
                  text: uploadedAt != null ? value : '-',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUploadState({
    required ThemeData theme,
    required SessionFileUploadState state,
  }) {
    String label;
    Color? color;

    switch (state) {
      case SessionFileUploadState.assetImageAlreadyExists:
        label = 'ALREADY IMPORTED';
        color = Colors.green;
        break;
      case SessionFileUploadState.error:
        label = 'ERROR';
        color = Colors.red;
        break;
      case SessionFileUploadState.invalidFileType:
        label = 'INVALID FILE TYPE';
        color = Colors.yellow;
        break;
      case SessionFileUploadState.sessionFileAlreadyExists:
        label = 'ALREADY UPLOADED';
        color = Colors.yellow;
        break;
      default:
        label = '';
        break;
    }

    return Text(
      label,
      maxLines: 1,
      softWrap: false,
      style: theme.textTheme.titleSmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
