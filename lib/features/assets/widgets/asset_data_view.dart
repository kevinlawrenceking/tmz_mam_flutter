import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/features/assets/widgets/asset_tile_item.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/utils/config.dart';

class AssetDataView extends StatefulWidget {
  final ScrollController scrollController;
  final Config config;
  final List<AssetDetailsModel> assets;
  final LayoutModeEnum layoutMode;
  final ThumbnailSizeEnum thumbnailSize;
  final void Function(AssetDetailsModel model) onItemClicked;
  final void Function(List<String> selectedIDs) onSelectionChanged;

  const AssetDataView({
    super.key,
    required this.scrollController,
    required this.config,
    required this.assets,
    required this.layoutMode,
    required this.thumbnailSize,
    required this.onItemClicked,
    required this.onSelectionChanged,
  });

  @override
  State<AssetDataView> createState() => _AssetDataViewState();
}

class _AssetDataViewState extends State<AssetDataView> {
  final _selectIDs = <String>[];

  @override
  Widget build(BuildContext context) {
    if (widget.layoutMode == LayoutModeEnum.list) {
      return Container();
    } else {
      return _buildTileView();
    }
  }

  Widget _buildTileItem({
    required BuildContext context,
    required double margin,
    required double width,
    required AssetDetailsModel model,
  }) {
    return GestureDetector(
      onTap: () {
        if (!_selectIDs.any((id) => id == model.id)) {
          if (!HardwareKeyboard.instance.isControlPressed) {
            _selectIDs.clear();
          }
          _selectIDs.add(model.id);
        } else {
          if (!HardwareKeyboard.instance.isControlPressed) {
            _selectIDs.removeWhere((id) => id != model.id);
          }
        }

        if (mounted) {
          setState(() {});
        }

        if (!HardwareKeyboard.instance.isControlPressed) {
          widget.onItemClicked(model);
        }

        widget.onSelectionChanged(_selectIDs);
      },
      child: Container(
        padding: EdgeInsets.all(margin),
        width: width,
        child: AssetTileItem(
          apiBaseUrl: widget.config.apiBaseUrl,
          scrollController: widget.scrollController,
          model: model,
          selected: _selectIDs.any((id) => id == model.id),
        ),
      ),
    );
  }

  Widget _buildTileView() {
    const itemMargin = 10.0;

    double maxItemWidth;

    switch (widget.thumbnailSize) {
      case ThumbnailSizeEnum.small:
        maxItemWidth = 230.0;
        break;
      case ThumbnailSizeEnum.medium:
        maxItemWidth = 350.0;
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
        if (columns <= widget.assets.length) {
          itemWidth = width / columns;
        } else {
          itemWidth = maxItemWidth;
        }

        return Padding(
          padding: const EdgeInsets.all(itemMargin),
          child: Wrap(
            children: widget.assets
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
