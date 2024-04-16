import 'package:flutter/material.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/scroll_aware_builder.dart';

class AssetListItem extends StatefulWidget {
  final ScrollController scrollController;
  final String apiBaseUrl;
  final AssetDetailsModel model;
  final bool selected;

  const AssetListItem({
    super.key,
    required this.apiBaseUrl,
    required this.scrollController,
    required this.model,
    required this.selected,
  });

  @override
  State<AssetListItem> createState() => _AssetListItemState();
}

class _AssetListItemState extends State<AssetListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: widget.selected
            ? Border.all(
                color: const Color(0xFF8E0000),
                width: 3.0,
              )
            : const Border.symmetric(
                vertical: BorderSide(
                  color: Color(0x20000000),
                ),
              ),
      ),
      child: Row(
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
          const Spacer(),
        ],
      ),
    );
  }
}
