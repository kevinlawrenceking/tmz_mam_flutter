import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class ActionsDropDownMenuAssetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrapping the content with a Material widget
    return Material(
      child: Container(
        width: 250,

        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView(
          shrinkWrap: true, // Ensures the ListView takes up only the space it needs
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

  Widget buildActionItem(BuildContext context, String title, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHeader)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0), // Reduced padding for header
              child: Text(
                title,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Roboto', // Assuming 'Roboto' as an example
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            ListTile(
              title: Text(
                title,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Roboto', // Assuming 'Roboto' as an example
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              onTap: () {
                // Handle your action tap here
                Navigator.pop(context); // Close the modal when an item is tapped
              },
            ),
          Divider(
            color: FlutterFlowTheme.of(context).primaryBackground,
            height: 1,
          ),
        ],
      ),
    );
  }
}
