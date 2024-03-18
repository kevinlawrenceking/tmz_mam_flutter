import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tmz_damz/components/flutter_flow_icon_button.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
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

    String? imageUrl;

    final image = model.images.firstWhereOrNull(
          (_) => _.type == AssetImageTypeEnum.hd1080,
        ) ??
        model.images.firstWhereOrNull(
          (_) =>
              (_.type == AssetImageTypeEnum.source) &&
              (_.width <= 1920) &&
              (_.height <= 1080),
        );

    if (image != null) {
      imageUrl = '$apiBaseUrl/asset/${model.id}/image/${image.id}';
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _Toolbar(
          //   model: model,
          // ),
          // Divider(
          //   indent: 8.0,
          //   endIndent: 8.0,
          //   thickness: 1.0,
          //   color: FlutterFlowTheme.of(context).secondaryText,
          // ),
          Text(
            model.headline,
            style: FlutterFlowTheme.of(context).headlineLarge,
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: MaskedScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.black,
                      child: FileThumbnail(
                        url: imageUrl ??
                            '$apiBaseUrl/asset/${model.id}/thumbnail',
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
                    metadata: model.metadata,
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
  final AssetMetadataModel metadata;

  const _MetadataContainer({
    required this.metadata,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x20000000),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metadata',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Celebrity',
            value: metadata.celebrityInPhoto.isNotEmpty
                ? metadata.celebrityInPhoto.join(', ')
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Associated Celebrity',
            value: metadata.celebrityAssociated.isNotEmpty
                ? metadata.celebrityAssociated.join(', ')
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Shot Description',
            value: metadata.shotDescription.isNotEmpty
                ? metadata.shotDescription
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Rights Summary',
            value: () {
              switch (metadata.rights) {
                case AssetMetadataRightsEnum.costNonTMZ:
                  return 'Cost (Non-TMZ)';
                case AssetMetadataRightsEnum.freeNonTMZ:
                  return 'Free (Non-TMZ)';
                case AssetMetadataRightsEnum.freeTMZ:
                  return 'Free (TMZ)';
                default:
                  return '-';
              }
            }(),
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Agency',
            value:
                metadata.agency.isNotEmpty ? metadata.agency.join(', ') : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Credit',
            value:
                metadata.credit?.isNotEmpty ?? false ? metadata.credit! : '-',
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              label.toUpperCase(),
              softWrap: false,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
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
