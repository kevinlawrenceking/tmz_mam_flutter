import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmz_damz/components/flutter_flow_icon_button.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';
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
                    model: model,
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
  final AssetDetailsModel model;

  const _MetadataContainer({
    required this.model,
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
          if (!model.metadata.celebrity) ...[
            _buildMetadata(
              context: context,
              theme: theme,
              label: 'Celebrity',
              value: 'Not Applicable',
              valueStyle: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                letterSpacing: 1,
              ),
            ),
          ] else ...[
            _buildMetadata(
              context: context,
              theme: theme,
              label: 'Celebrity',
              canCopy: model.metadata.celebrityInPhoto.isNotEmpty,
              value: model.metadata.celebrityInPhoto.isNotEmpty
                  ? model.metadata.celebrityInPhoto.join(', ')
                  : '-',
            ),
            _buildMetadata(
              context: context,
              theme: theme,
              label: 'Associated Celebrity',
              canCopy: model.metadata.celebrityAssociated.isNotEmpty,
              value: model.metadata.celebrityAssociated.isNotEmpty
                  ? model.metadata.celebrityAssociated.join(', ')
                  : '-',
            ),
          ],
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Shot Description',
            canCopy: model.metadata.shotDescription.isNotEmpty,
            value: model.metadata.shotDescription.isNotEmpty
                ? model.metadata.shotDescription
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Keywords',
            value: model.metadata.keywords.isNotEmpty
                ? model.metadata.keywords.join(', ')
                : '-',
            canCopy: model.metadata.keywords.isNotEmpty,
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Shoot Location',
            canCopy: model.metadata.location.description?.isNotEmpty ?? false,
            value: (model.metadata.location.description?.isNotEmpty ?? false)
                ? model.metadata.location.description!
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'City, State, Country',
            canCopy: model.metadata.keywords.isNotEmpty,
            value: (() {
              final parts = <String>[];

              if (model.metadata.location.city?.isNotEmpty ?? false) {
                parts.add(model.metadata.location.city!);
              }
              if (model.metadata.location.state?.isNotEmpty ?? false) {
                parts.add(model.metadata.location.state!);
              }
              if (model.metadata.location.country?.isNotEmpty ?? false) {
                parts.add(model.metadata.location.country!);
              }

              if (parts.isNotEmpty) {
                return parts.join(', ');
              } else {
                return '-';
              }
            })(),
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Shoot Date',
            canCopy: model.images.any(
              (_) => _.type == AssetImageTypeEnum.source,
            ),
            value: (() {
              final dt = model.images
                  .firstWhereOrNull(
                    (_) => _.type == AssetImageTypeEnum.source,
                  )
                  ?.createdAt
                  .toLocal();

              if (dt != null) {
                return DateFormat.yMMMMd().add_jms().format(dt);
              } else {
                return '-';
              }
            })(),
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Source',
            canCopy: model.metadata.agency.isNotEmpty,
            value: model.metadata.agency.isNotEmpty
                ? model.metadata.agency.join(', ')
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Credit',
            canCopy: model.metadata.credit?.isNotEmpty ?? false,
            value: model.metadata.credit?.isNotEmpty ?? false
                ? model.metadata.credit!
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Rights Summary',
            value: () {
              switch (model.metadata.rights) {
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
            label: 'Rights Details',
            canCopy: model.metadata.rightsDetails?.isNotEmpty ?? false,
            value: model.metadata.rightsDetails?.isNotEmpty ?? false
                ? model.metadata.rightsDetails!
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Rights Instructions',
            canCopy: model.metadata.rightsInstructions?.isNotEmpty ?? false,
            value: model.metadata.rightsInstructions?.isNotEmpty ?? false
                ? model.metadata.rightsInstructions!
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Credit Location',
            value: () {
              switch (model.metadata.creditLocation) {
                case AssetMetadataCreditLocationEnum.end:
                  return 'End';
                case AssetMetadataCreditLocationEnum.onScreen:
                  return 'On-Screen';
                default:
                  return '-';
              }
            }(),
          ),
          // TODO: 'On Screen Credit'
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Censor Required',
            value: () {
              final parts = <String>[];

              for (var i = 0; i < model.metadata.overlay.length; i++) {
                switch (model.metadata.overlay[i]) {
                  case AssetMetadataOverlayEnum.blackBarCensor:
                    parts.add('Black Bar');
                  case AssetMetadataOverlayEnum.blurCensor:
                    parts.add('Blur');
                  default:
                    break;
                }
              }

              parts.sort();

              if (parts.isNotEmpty) {
                return parts.join(', ');
              } else {
                return 'No';
              }
            }(),
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Watermark Required',
            value: model.metadata.overlay
                    .any((_) => _ == AssetMetadataOverlayEnum.watermark)
                ? 'Yes'
                : 'No',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Exclusivity',
            value: () {
              switch (model.metadata.exclusivity) {
                case AssetMetadataExclusivityEnum.exclusive:
                  return 'Exclusive';
                case AssetMetadataExclusivityEnum.premiumExclusive:
                  return 'Premium Exclusive';
                default:
                  return '-';
              }
            }(),
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Emotion',
            value: () {
              final parts = <String>[];

              for (var i = 0; i < model.metadata.emotion.length; i++) {
                switch (model.metadata.emotion[i]) {
                  case AssetMetadataEmotionEnum.negative:
                    parts.add('Negative');
                  case AssetMetadataEmotionEnum.neutral:
                    parts.add('Neutral');
                  case AssetMetadataEmotionEnum.positive:
                    parts.add('Positive');
                  case AssetMetadataEmotionEnum.surprised:
                    parts.add('Surprised');
                  default:
                    break;
                }
              }

              if (parts.isNotEmpty) {
                return parts.join(', ');
              } else {
                return '-';
              }
            }(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    bool canCopy = false,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              label.toUpperCase(),
              softWrap: true,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          canCopy
              ? CopyText(
                  value,
                  style: valueStyle ??
                      theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                )
              : Text(
                  value,
                  style: valueStyle ??
                      theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
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
    const columnWidths = [280.0, 160.0, 200.0];

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
                canCopy: true,
                label: 'ID',
                value: model?.id ?? '',
              ),
            ),
            const SizedBox(width: 20.0),
            SizedBox(
              width: columnWidths[1],
              child: _buildColumn(
                context: context,
                theme: theme,
                canCopy: false,
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
            const SizedBox(width: 20.0),
            SizedBox(
              width: columnWidths[2],
              child: _buildColumn(
                context: context,
                theme: theme,
                canCopy: true,
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
              width: columnWidths[0],
              child: _buildColumn(
                context: context,
                theme: theme,
                canCopy: true,
                label: 'ORIGINAL FILE NAME',
                value: model?.originalFileName ?? '',
              ),
            ),
            const SizedBox(width: 20.0),
            SizedBox(
              width: columnWidths[1],
              child: _buildColumn(
                context: context,
                theme: theme,
                canCopy: true,
                label: 'CREATED',
                value: (() {
                  if (model?.createdAt != null) {
                    return DateFormat.yMd()
                        .add_jms()
                        .format(model!.createdAt.toLocal());
                  } else {
                    return '-';
                  }
                })(),
              ),
            ),
            const SizedBox(width: 20.0),
            SizedBox(
              width: columnWidths[2],
              child: _buildColumn(
                context: context,
                theme: theme,
                canCopy: true,
                label: 'UPDATED',
                value: (() {
                  if (model?.updatedAt != null) {
                    return DateFormat.yMd()
                        .add_jms()
                        .format(model!.updatedAt.toLocal());
                  } else {
                    return '-';
                  }
                })(),
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
    required bool canCopy,
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
              letterSpacing: 1,
            ),
          ),
        ),
        canCopy
            ? CopyText(
                value,
                maxLines: 1,
                softWrap: false,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Text(
                value,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
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
