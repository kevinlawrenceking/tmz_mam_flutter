import 'package:flutter/material.dart';
import 'package:tmz_damz/components/flutter_flow_icon_button.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';

class Toolbar extends StatelessWidget {
  final AssetDetailsModel model;

  const Toolbar({
    super.key,
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
