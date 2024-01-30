import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class ActionsDropDownMenuAssetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView(
        shrinkWrap: true, // Ensure the ListView only occupies needed space
        children: [
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
        ],
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
            Text(
              title,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            )
          else
            ListTile(
              title: Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              onTap: () {
                // Handle your action tap here
              },
            ),
          Divider(color: FlutterFlowTheme.of(context).primaryBackground, thickness: 1),
        ],
      ),
    );
  }
}
