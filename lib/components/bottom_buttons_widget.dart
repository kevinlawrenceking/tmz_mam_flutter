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
  final String currentScreen;

  const BottomButtonsWidget({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Assets Button
            _BottomButton(
              icon: Icons.image_search,
              label: 'Assets',
              isActive: currentScreen ==
                  'Assets', // Check if current screen is 'Assets'
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              )),
            ),

            // Collections Button
            _BottomButton(
              icon: Icons.folder_outlined,
              label: 'Collections',
              isActive: currentScreen ==
                  'Collections', // Check if current screen is 'Collections'
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const CollectionsPage(),
              )),
            ),

            // Admin Button
            _BottomButton(
              icon: Icons.admin_panel_settings_outlined,
              label: 'Admin',
              isActive: currentScreen ==
                  'Admin', // Check if current screen is 'Admin'
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminPage(),
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
  final bool isActive;
  final VoidCallback onTap;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? Colors.red
                : FlutterFlowTheme.of(context).primaryText, // Red if active
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? Colors.red
                  : FlutterFlowTheme.of(context)
                      .primaryText, // Text color also red if active
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
