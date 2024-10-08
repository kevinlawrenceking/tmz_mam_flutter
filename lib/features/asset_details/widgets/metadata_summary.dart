import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';

class MetadataSummary extends StatelessWidget {
  final AssetDetailsModel model;

  const MetadataSummary({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metadata',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 20.0),
        if (model.metadata.daletID != null)
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Dalet ID',
            canCopy: true,
            value: model.metadata.daletID!.toString(),
          ),
        if (!(model.metadata.celebrity ?? false)) ...[
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
            canCopy: model.metadata.celebrityInPhoto?.isNotEmpty ?? false,
            value: model.metadata.celebrityInPhoto?.isNotEmpty ?? false
                ? model.metadata.celebrityInPhoto!.join(', ')
                : '-',
          ),
          _buildMetadata(
            context: context,
            theme: theme,
            label: 'Associated Celebrity',
            canCopy: model.metadata.celebrityAssociated?.isNotEmpty ?? false,
            value: model.metadata.celebrityAssociated?.isNotEmpty ?? false
                ? model.metadata.celebrityAssociated!.join(', ')
                : '-',
          ),
        ],
        _buildMetadata(
          context: context,
          theme: theme,
          label: 'Shot Description',
          canCopy: model.metadata.shotDescription?.isNotEmpty ?? false,
          value: model.metadata.shotDescription?.isNotEmpty ?? false
              ? model.metadata.shotDescription!
              : '-',
        ),
        _buildMetadata(
          context: context,
          theme: theme,
          label: 'Keywords',
          canCopy: model.metadata.keywords?.isNotEmpty ?? false,
          value: model.metadata.keywords?.isNotEmpty ?? false
              ? model.metadata.keywords!.join(', ')
              : '-',
        ),
        _buildMetadata(
          context: context,
          theme: theme,
          label: 'Shoot Location',
          canCopy: model.metadata.location?.description?.isNotEmpty ?? false,
          value: (model.metadata.location?.description?.isNotEmpty ?? false)
              ? model.metadata.location!.description!
              : '-',
        ),
        _buildMetadata(
          context: context,
          theme: theme,
          label: (() {
            final parts = <String>[];

            if (model.metadata.location?.city?.isNotEmpty ?? false) {
              parts.add('City');
            }
            if (model.metadata.location?.state?.isNotEmpty ?? false) {
              parts.add('State');
            }
            if (model.metadata.location?.country?.isNotEmpty ?? false) {
              parts.add('Country');
            }

            if (parts.isNotEmpty) {
              return parts.join(', ');
            } else {
              return 'City, State, Country';
            }
          })(),
          value: (() {
            final parts = <String>[];

            if (model.metadata.location?.city?.isNotEmpty ?? false) {
              parts.add(model.metadata.location!.city!);
            }
            if (model.metadata.location?.state?.isNotEmpty ?? false) {
              parts.add(model.metadata.location!.state!);
            }
            if (model.metadata.location?.country?.isNotEmpty ?? false) {
              parts.add(model.metadata.location!.country!);
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
          canCopy: model.metadata.agency?.isNotEmpty ?? false,
          value: model.metadata.agency?.isNotEmpty ?? false
              ? model.metadata.agency!.join(', ')
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

            if (model.metadata.overlay != null) {
              for (var i = 0; i < model.metadata.overlay!.length; i++) {
                switch (model.metadata.overlay![i]) {
                  case AssetMetadataOverlayEnum.blackBarCensor:
                    parts.add('Black Bar');
                  case AssetMetadataOverlayEnum.blurCensor:
                    parts.add('Blur');
                  default:
                    break;
                }
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
          value: (model.metadata.overlay?.any(
                    (_) => _ == AssetMetadataOverlayEnum.watermark,
                  ) ??
                  false)
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

            if (model.metadata.emotion != null) {
              for (var i = 0; i < model.metadata.emotion!.length; i++) {
                switch (model.metadata.emotion![i]) {
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
            }

            if (parts.isNotEmpty) {
              return parts.join(', ');
            } else {
              return '-';
            }
          }(),
        ),
        _buildMetadata(
          context: context,
          theme: theme,
          label: 'QC Notes',
          canCopy: model.metadata.qcNotes?.isNotEmpty ?? false,
          value: model.metadata.qcNotes?.isNotEmpty ?? false
              ? model.metadata.qcNotes!
              : '-',
        ),
      ],
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
      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
