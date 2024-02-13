// ignore_for_file: avoid_print

import 'package:tmz_mam_flutter/components/flutter_flow_icon_button.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
export 'package:tmz_mam_flutter/models/media_page_control_bar_model.dart';
import 'package:flutter/services.dart';

class MediaPageControlBarWidget extends StatefulWidget {
  final String? imageUrl; // Make it nullable

  const MediaPageControlBarWidget({
    super.key,
    this.imageUrl, // Remove `required` and provide a default value if needed
  });

  @override
  MediaPageControlBarWidgetState createState() =>
      MediaPageControlBarWidgetState();
}

class MediaPageControlBarWidgetState extends State<MediaPageControlBarWidget> {
  @override
  void initState() {
    super.initState();
    // Initialize your model here
  }

  @override
  void dispose() {
    // Dispose your model here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5, 5.0, 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildIconButton(
            context,
            icon: Icons.file_download_outlined,
            onPressed: () => print('Download IconButton pressed'),
          ),
          buildIconButton(
            context,
            icon: Icons.edit_sharp,
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // This opens the drawer
            },
          ),
          buildIconButton(
            context,
            icon: Icons.create_new_folder,
            onPressed: () => print('Create New Folder IconButton pressed'),
          ),
          buildIconButton(
            context,
            icon: Icons.delete_outlined,
            onPressed: () => print('Delete IconButton pressed'),
          ),
          buildIconButton(
            context,
            icon: Icons.more_vert,
            onPressed: () => print('More Options IconButton pressed'),
          ),
          const Spacer(),
          buildIconButton(
            context,
            icon: Icons.navigate_before,
            onPressed: () => print('Navigate Before IconButton pressed'),
          ),
          buildIconButton(
            context,
            icon: Icons.navigate_next,
            onPressed: () => print('Navigate Next IconButton pressed'),
          ),
          buildIconButton(
            context,
            icon: Icons.close,
            onPressed: () => print('Close IconButton pressed'),
          ),
        ],
      ),
    );
  }

  Widget buildIconButton(BuildContext context,
      {required IconData icon, required VoidCallback onPressed}) {
    return FlutterFlowIconButton(
      borderColor: FlutterFlowTheme.of(context).primary,
      borderRadius: 15.0,
      borderWidth: 1.0,
      buttonSize: 36.0,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      icon: Icon(
        icon,
        color: FlutterFlowTheme.of(context).primaryText,
        size: 24.0,
      ),
      onPressed: onPressed,
    );
  }
}
