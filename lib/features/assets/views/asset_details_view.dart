import 'package:flutter/material.dart';
import 'package:tmz_damz/components/flutter_flow_icon_button.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/inventory_metadata.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';

class AssetDetailsView extends StatelessWidget {
  final String apiBaseUrl;
  final AssetDetailsModel model;

  const AssetDetailsView({
    super.key,
    required this.apiBaseUrl,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Toolbar(
            model: model,
          ),
          Divider(
            indent: 8.0,
            endIndent: 8.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
          Text(
            model.headline,
            style: FlutterFlowTheme.of(context).headlineLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.black,
                      child: FileThumbnail(
                        url: '$apiBaseUrl/asset/${model.id}/thumbnail',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'CATEGORIES:',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color:
                          theme.textTheme.labelSmall?.color?.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '-', // model.categories,
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'APPEARS IN:',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color:
                          theme.textTheme.labelSmall?.color?.withOpacity(0.4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '-', // model.collections,
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 20),
                  _MetadataContainer(
                    metadata: [], //model.metadata,
                  ),
                  const SizedBox(height: 20),
                  _PhotoInfoContainer(
                    model: model,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataContainer extends StatelessWidget {
  final List<InventoryMetadataModel> metadata;

  const _MetadataContainer({
    required this.metadata,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x20000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Metadata',
              style: theme.textTheme.titleLarge,
            ),
          ),
          ...metadata.map(
            (meta) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      meta.label?.toUpperCase() ?? '',
                      softWrap: false,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    meta.value ?? '-',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoInfoContainer extends StatelessWidget {
  final AssetDetailsModel? model;

  const _PhotoInfoContainer({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    const columnWidths = [160.0, 200.0, 340.0];

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x20000000),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          runSpacing: 10,
          children: [
            SizedBox(
              width: columnWidths[0],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'ID',
                value: model?.id ?? '',
              ),
            ),
            SizedBox(
              width: columnWidths[1],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'STATUS',
                value: () {
                  switch (model?.status) {
                    case AssetStatusEnum.available:
                      return 'Available';
                    case AssetStatusEnum.processing:
                      return 'Processing';
                    default:
                      return '-';
                  }
                }(),
              ),
            ),
            SizedBox(
              width: columnWidths[2],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'ORIGINAL FILE NAME',
                value: model?.originalFileName ?? '',
              ),
            ),
            SizedBox(
              width: columnWidths[0],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'CREATED BY',
                value: () {
                  if (model?.createdBy != null) {
                    final firstName = model!.createdBy.firstName;
                    final lastName = model!.createdBy.lastName;
                    return '$firstName $lastName';
                  } else {
                    return '';
                  }
                }(),
              ),
            ),
            SizedBox(
              width: columnWidths[1],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'CREATED',
                value: model?.createdAt.toLocal().toString() ?? '',
              ),
            ),
            SizedBox(
              width: columnWidths[2],
              child: _buildColumn(
                context: context,
                theme: theme,
                label: 'UPDATED',
                value: model?.updatedAt.toLocal().toString() ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.4,
          child: Text(
            label,
            maxLines: 1,
            softWrap: false,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          value,
          maxLines: 1,
          softWrap: false,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _Toolbar extends StatelessWidget {
  final AssetDetailsModel model;

  const _Toolbar({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          _buildIconButton(
            context: context,
            icon: Icons.file_download_outlined,
            onPressed: () async {
              // final url = Uri.parse(model.mediaPath);
              // if (!await launchUrl(url)) {
              //   Toast.showNotification(
              //     type: ToastTypeEnum.error,
              //     showDuration: const Duration(seconds: 8),
              //     title: '',
              //     message: 'Could not launch $url',
              //   );
              // }
            },
          ),
          _buildIconButton(
            context: context,
            icon: Icons.edit_sharp,
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // This opens the drawer
            },
          ),
          _buildIconButton(
            context: context,
            icon: Icons.create_new_folder,
            onPressed: () {
              //
            },
          ),
          _buildIconButton(
            context: context,
            icon: Icons.delete_outlined,
            onPressed: () {
              //
            },
          ),
          _buildIconButton(
            context: context,
            icon: Icons.more_vert,
            onPressed: () {
              //
            },
          ),
          const Spacer(),
          _buildIconButton(
            context: context,
            icon: Icons.close,
            onPressed: () {
              //
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FlutterFlowIconButton(
        borderColor: FlutterFlowTheme.of(context).primary,
        borderRadius: 15.0,
        buttonSize: 36.0,
        borderWidth: 1.0,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        icon: Icon(
          icon,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 24.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
