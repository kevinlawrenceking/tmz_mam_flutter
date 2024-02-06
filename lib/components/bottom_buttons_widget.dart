import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/screens/search_screen.dart';
import 'package:tmz_mam_flutter/components/collections_widget.dart';
import 'package:tmz_mam_flutter/screens/admin_screen.dart';

/// Builds the bottom navigation bar for the app.
///
/// This method returns a container with a row of bottom navigation buttons.
/// Each button represents a different section of the app, allowing the user to
/// navigate between the assets, collections, and admin screens.
///
/// The navigation bar uses a [SafeArea] widget to ensure it is not obscured
/// by the lower part of the screen, such as the bottom notch or the
/// system navigation bar on certain devices. The buttons are spaced evenly
/// across the width of the screen using [MainAxisAlignment.spaceEvenly].
///
/// Each button is an instance of the [_BottomButton] private widget, configured
/// with an icon, a label, and a callback function that navigates to the
/// respective screen using a [MaterialPageRoute].
///

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          FlutterFlowTheme.of(context).secondaryBackground, // Background color
      child: SafeArea(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Space the buttons evenly
          children: [
            // Assets Button
            _BottomButton(
              icon: Icons.image_search,
              label: 'Assets',
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    const SearchScreen(), // Navigate to Assets Screen
              )),
            ),

            // Collections Button
            _BottomButton(
              icon: Icons.folder_outlined,
              label: 'Collections',
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    const CollectionsPage(), // Navigate to Collections Screen
              )),
            ),

            // Admin Button
            _BottomButton(
              icon: Icons.admin_panel_settings_outlined,
              label: 'Admin',
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    const AdminPage(), // Navigate to Admin Screen
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
          Icon(icon,
              color: FlutterFlowTheme.of(context).primaryText), // Icon color
          Text(label,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText, // Text color
                fontSize: 11.0, // Font size
              )),
        ],
      ),
    );
  }
}
