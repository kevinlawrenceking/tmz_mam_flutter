import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/data/models/inventory.dart';
import 'package:tmz_mam_flutter/data/models/inventory_metadata.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/inventory_item_thumbnail.dart';
import 'package:tmz_mam_flutter/shared/widgets/scroll_aware_builder.dart';

class InventoryTileItem extends StatefulWidget {
  final ScrollController scrollController;
  final InventoryModel model;

  const InventoryTileItem({
    super.key,
    required this.scrollController,
    required this.model,
  });

  @override
  State<InventoryTileItem> createState() => _InventoryTileItemState();
}

class _InventoryTileItemState extends State<InventoryTileItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0x80000000),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[3],
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
                  builder: (context) => InventoryItemThumbnail(
                    url: widget.model.thumbnail,
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
                    widget.model.name,
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
                  ...widget.model.metadata.map(
                    (metadata) => _buildMetadata(
                      context: context,
                      theme: theme,
                      metadata: metadata,
                    ),
                  ),
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
    required InventoryMetadataModel metadata,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              metadata.label?.toUpperCase() ?? '',
              softWrap: false,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            metadata.value ?? '-',
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
