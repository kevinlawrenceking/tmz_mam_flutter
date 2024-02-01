import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/actions_page.dart';

class ActionsDropDownMenuAssetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Material(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.darkThemeShadowColor.withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 2.0),
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

  Widget buildActionItem(BuildContext context, String text, {bool isHeader = false}) {
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
        splashColor: theme.accent1.withOpacity(0.5),
        child: MouseRegion(
          onEnter: (_) {
            // Handle hover effects here
            // You can add animations or change the appearance here
          },
          onExit: (_) {
            // Reset hover effects here if needed
          },
          child: Container(
            height: isHeader ? 75.0 : 50.0,
            decoration: BoxDecoration(
              color: isHeader ? theme.primary : theme.secondaryBackground,
              borderRadius: isHeader
                  ? BorderRadius.only(
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
              boxShadow: isHeader
                  ? [
                      BoxShadow(
                        color: theme.accent1.withOpacity(0.5),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: theme.accent1.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
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
