import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/flutter_flow_theme.dart';

import 'package:tmz_mam_flutter/search_screen.dart';
import 'package:tmz_mam_flutter/pages/collections/collections_widget.dart';
import 'package:tmz_mam_flutter/admin_page.dart';
 
class BottomButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlutterFlowTheme.of(context).secondaryBackground, // Background color
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space the buttons evenly
          children: [
            // Assets Button
            _BottomButton(
              icon: Icons.image_search,
              label: 'Assets',
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SearchScreen(), // Navigate to Assets Screen
              )),
            ),

            // Collections Button
            _BottomButton(
              icon: Icons.folder_outlined,
              label: 'Collections',
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CollectionsPage(), // Navigate to Collections Screen
              )),
            ),

            // Admin Button
            _BottomButton(
              icon: Icons.admin_panel_settings_outlined,
              label: 'Admin',
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminPage(), // Navigate to Admin Screen
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Take up minimum space
        children: [
          Icon(icon, color: FlutterFlowTheme.of(context).primaryText), // Icon color
          Text(label, style: TextStyle(
            color: FlutterFlowTheme.of(context).primaryText, // Text color
            fontSize: 11.0, // Font size
          )),
        ],
      ),
    );
  }
}
