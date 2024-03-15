import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Use MainAxisSize.min to fit the content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'My Profile',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.security,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            title: Text(
              'Permissions',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.grain,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            title: Text(
              'Configure View',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            title: Text(
              'Sign Out',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
