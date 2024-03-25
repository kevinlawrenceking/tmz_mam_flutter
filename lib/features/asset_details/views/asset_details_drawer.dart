import 'package:flutter/material.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/features/asset_details/widgets/asset_details.dart';

class AssetDetailsDrawer extends StatelessWidget {
  final AssetDetailsModel? model;
  final VoidCallback onClose;

  const AssetDetailsDrawer({
    super.key,
    required this.model,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 600.0,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                ),
                color: Color(0xFF232323),
              ),
              child: MouseRegion(
                child: Material(
                  child: AssetDetails(
                    assetID: model?.id,
                    onClose: onClose,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
