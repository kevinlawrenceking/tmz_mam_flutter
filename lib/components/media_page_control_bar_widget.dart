// ignore_for_file: avoid_print

import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import 'package:flutter/material.dart';
export '../models/media_page_control_bar_model.dart';

class MediaPageControlBarWidget extends StatefulWidget {
  const MediaPageControlBarWidget({super.key});

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
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0, 15.0, 0),
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
      borderWidth: 2.0,
      buttonSize: 40.0,
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
