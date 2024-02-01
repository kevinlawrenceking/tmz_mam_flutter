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

  Widget buildActionItem(BuildContext context, String text, {bool isHeader = false}) {
    if (isHeader) {
      return Container(
        width: 100.0,
        height: 75.0,
        decoration: BoxDecoration(
          color: Colors.red, // Red background color
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white, // White font color
              fontSize: 18.0, // Adjust the font size as needed
            ),
          ),
        ),
      );
    } else {
      // Add your code for non-header items here
      // You can customize the appearance of non-header items in this block
      return Container(
        // Customize the appearance of non-header items here
      );
    }
  }
}
