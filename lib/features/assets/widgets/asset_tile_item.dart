import 'package:flutter/material.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/features/assets/widgets/asset_item_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/scroll_aware_builder.dart';

class AssetTileItem extends StatefulWidget {
  final ScrollController scrollController;
  final String apiBaseUrl;
  final AssetDetailsModel model;

  const AssetTileItem({
    super.key,
    required this.apiBaseUrl,
    required this.scrollController,
    required this.model,
  });

  @override
  State<AssetTileItem> createState() => _AssetTileItemState();
}

class _AssetTileItemState extends State<AssetTileItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0x20000000),
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[3],
        color: Colors.black,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: ScrollAwareBuilder(
                  controller: widget.scrollController,
                  builder: (context) => AssetItemThumbnail(
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
                  _buildMetadata(
                    context: context,
                    theme: theme,
                    label: 'Celebrity',
                    value: widget.model.metadata.celebrityInPhoto.isNotEmpty
                        ? widget.model.metadata.celebrityInPhoto.join(', ')
                        : '-',
                  ),
                  _buildMetadata(
                    context: context,
                    theme: theme,
                    label: 'Associated Celebrity',
                    value: widget.model.metadata.celebrityAssociated.isNotEmpty
                        ? widget.model.metadata.celebrityAssociated.join(', ')
                        : '-',
                  ),
                  _buildMetadata(
                    context: context,
                    theme: theme,
                    label: 'Shot Description',
                    value: widget.model.metadata.shotDescription.isNotEmpty
                        ? widget.model.metadata.shotDescription
                        : '-',
                  ),
                  _buildMetadata(
                    context: context,
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
                  _buildMetadata(
                    context: context,
                    theme: theme,
                    label: 'Agency',
                    value: widget.model.metadata.agency.isNotEmpty
                        ? widget.model.metadata.agency.join(', ')
                        : '-',
                  ),
                  _buildMetadata(
                    context: context,
                    theme: theme,
                    label: 'Credit',
                    value: widget.model.metadata.credit?.isNotEmpty ?? false
                        ? widget.model.metadata.credit!
                        : '-',
                  ),
                  // _buildMetadata(
                  //   context: context,
                  //   theme: theme,
                  //   label: 'Rights Details',
                  //   value: widget.model.metadata.rightsDetails?.isNotEmpty ?? false
                  //       ? widget.model.metadata.rightsDetails!
                  //       : '-',
                  // ),
                ],
              ),
            ),
          ],
        ),
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
