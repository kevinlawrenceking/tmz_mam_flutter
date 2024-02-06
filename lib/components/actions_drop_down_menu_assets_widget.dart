import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/screens/actions_page.dart';

/// A widget that displays a dropdown menu for actions.
///
/// This dropdown menu includes system actions and workflows that can be triggered by the user.
/// Each action is represented as an item in the list, and selecting an action navigates to the [ActionsPage].

class ActionsDropDownMenuAssetsWidget extends StatelessWidget {
  /// Creates an [ActionsDropDownMenuAssetsWidget].
  const ActionsDropDownMenuAssetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: FlutterFlowTheme.of(context)
                  .darkThemeShadowColor
                  .withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildActionItem(context, 'System Actions', isHeader: true),
            buildActionItem(context, 'Add to a Collection'),
            buildActionItem(context, 'Batch Download'),
            buildActionItem(context, 'Batch Update'),
            buildActionItem(context, 'Delete'),
            buildActionItem(context, 'Download Search Results as CSV'),
            buildActionItem(context, 'Download Mezzanine'),
            buildActionItem(context, 'Download Proxy'),
            buildActionItem(context, 'Workflows', isHeader: true),
            buildActionItem(context, 'Send To 1920 x 1080 Collection'),

            // Add more items as needed
          ],
        ),
      ),
    );
  }

  Widget buildActionItem(BuildContext context, String text,
      {bool isHeader = false}) {
    final theme = FlutterFlowTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (!isHeader) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActionsPage(title: text),
              ),
            );
          }
        },
        splashColor: Colors.transparent,

        // No splash effect on tap
        hoverColor: Colors.transparent,

        // Color when hovered
        child: MouseRegion(
          onHover: (_) {
            // Handle hover effects here
          },
          child: Container(
            height: isHeader ? 75.0 : 50.0,
            decoration: BoxDecoration(
              color: isHeader ? theme.primary : theme.secondaryBackground,
              borderRadius: isHeader
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : null,
              border: !isHeader
                  ? Border(
                      bottom: BorderSide(
                        color: theme.lightGray,
                        width: 0.5,
                      ),
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: theme.primaryText,
                  fontSize: isHeader ? 18.0 : 16.0,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
