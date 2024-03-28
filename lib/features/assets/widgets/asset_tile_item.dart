import 'package:flutter/material.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/scroll_aware_builder.dart';

class AssetTileItem extends StatefulWidget {
  final ScrollController scrollController;
  final String apiBaseUrl;
  final AssetDetailsModel model;
  final bool selected;

  const AssetTileItem({
    super.key,
    required this.apiBaseUrl,
    required this.scrollController,
    required this.model,
    required this.selected,
  });

  @override
  State<AssetTileItem> createState() => _AssetTileItemState();
}

class _AssetTileItemState extends State<AssetTileItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[3],
        color: Colors.black,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: widget.selected
                ? const Color(0xFF8E0000)
                : const Color(0x20000000),
            width: widget.selected ? 3.0 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: ScrollAwareBuilder(
                  controller: widget.scrollController,
                  builder: (context) => FileThumbnail(
                    url:
                        '${widget.apiBaseUrl}/asset/${widget.model.id}/thumbnail',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model.headline,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      'ID: ${widget.model.id}',
                      style: theme.textTheme.labelSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 4),
                  _MetadataValue(
                    theme: theme,
                    label: 'Celebrity',
                    value: !widget.model.metadata.celebrity
                        ? 'Not Applicable'
                        : (widget.model.metadata.celebrityInPhoto.isNotEmpty
                            ? widget.model.metadata.celebrityInPhoto.join(', ')
                            : '-'),
                  ),
                  _MetadataValue(
                    theme: theme,
                    label: 'Associated Celebrity',
                    value: !widget.model.metadata.celebrity
                        ? '-'
                        : (widget.model.metadata.celebrityAssociated.isNotEmpty
                            ? widget.model.metadata.celebrityAssociated
                                .join(', ')
                            : '-'),
                  ),
                  _MetadataValue(
                    theme: theme,
                    label: 'Shot Description',
                    value: widget.model.metadata.shotDescription.isNotEmpty
                        ? widget.model.metadata.shotDescription
                        : '-',
                  ),
                  _MetadataValue(
                    theme: theme,
                    label: 'Rights Summary',
                    value: () {
                      switch (widget.model.metadata.rights) {
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
                  _MetadataValue(
                    theme: theme,
                    label: 'Agency',
                    value: widget.model.metadata.agency.isNotEmpty
                        ? widget.model.metadata.agency.join(', ')
                        : '-',
                  ),
                  _MetadataValue(
                    theme: theme,
                    label: 'Credit',
                    value: widget.model.metadata.credit?.isNotEmpty ?? false
                        ? widget.model.metadata.credit!
                        : '-',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetadataValue extends StatefulWidget {
  final ThemeData theme;
  final String label;
  final String value;

  const _MetadataValue({
    required this.theme,
    required this.label,
    required this.value,
  });

  @override
  State<_MetadataValue> createState() => _MetadataValueState();
}

class _MetadataValueState extends State<_MetadataValue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              widget.label.toUpperCase(),
              softWrap: false,
              style: widget.theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          Text(
            widget.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: widget.theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
