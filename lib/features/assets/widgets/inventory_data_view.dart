import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/data/models/inventory.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/inventory_tile_item.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/thumbnail_size_selector.dart';

class InventoryDataView extends StatelessWidget {
  final ScrollController scrollController;
  final List<InventoryModel> items;
  final LayoutModeEnum layoutMode;
  final ThumbnailSizeEnum thumbnailSize;
  final void Function(InventoryModel model) onItemClicked;

  const InventoryDataView({
    super.key,
    required this.scrollController,
    required this.items,
    required this.layoutMode,
    required this.thumbnailSize,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    if (layoutMode == LayoutModeEnum.list) {
      return Container();
    } else {
      return _buildTileView();
    }
  }

  Widget _buildTileItem({
    required BuildContext context,
    required double margin,
    required double width,
    required InventoryModel model,
  }) {
    return GestureDetector(
      onTap: () => onItemClicked(model),
      child: Container(
        padding: EdgeInsets.all(margin),
        width: width,
        child: InventoryTileItem(
          scrollController: scrollController,
          model: model,
        ),
      ),
    );
  }

  Widget _buildTileView() {
    const itemMargin = 10.0;

    double maxItemWidth;

    switch (thumbnailSize) {
      case ThumbnailSizeEnum.small:
        maxItemWidth = 230.0;
        break;
      case ThumbnailSizeEnum.medium:
        maxItemWidth = 300.0;
        break;
      case ThumbnailSizeEnum.large:
        maxItemWidth = 650.0;
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - (itemMargin * 2) - 2;
        final columns = (width / maxItemWidth).ceil();

        double itemWidth;
        if (columns <= items.length) {
          itemWidth = width / columns;
        } else {
          itemWidth = maxItemWidth;
        }

        return Padding(
          padding: const EdgeInsets.all(itemMargin),
          child: Wrap(
            children: items
                .map(
                  (model) => _buildTileItem(
                    context: context,
                    margin: itemMargin,
                    width: itemWidth,
                    model: model,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
