import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/components/flutter_flow_icon_button.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to add url_launcher to your pubspec.yaml

class MediaPageControlBarWidget extends StatefulWidget {
  final String? imageUrl; // Nullable imageUrl parameter

  const MediaPageControlBarWidget({Key? key, this.imageUrl})
      : super(key: key); // Initialize imageUrl in constructor

  @override
  MediaPageControlBarWidgetState createState() =>
      MediaPageControlBarWidgetState();
}

class MediaPageControlBarWidgetState extends State<MediaPageControlBarWidget> {
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
            onPressed: widget.imageUrl != null
                ? () async {
                    final Uri url = Uri.parse(widget.imageUrl!);
                    if (!await launchUrl(url)) {
                      throw 'Could not launch $url';
                    }
                  }
                : null, // Disable the button if imageUrl is null
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
      {required IconData icon, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 4.0), // Adjust the horizontal padding as needed
      child: FlutterFlowIconButton(
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
      ),
    );
  }
}
