// collections.dart
import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/themeprovider.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collections',
        actions: [
          IconButton(
         icon: Icon(Icons.brightness_6),
           onPressed: () {
              // Use Provider to toggle the theme
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(), // Search bar component
          MediaPageControlBarWidget(), // Toolbar component

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),

          // Title or any additional content can go here
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Collectionz',
                style: FlutterFlowTheme.of(context).headlineLarge,
              ),
            ),
          ),

          // Placeholder for future content
          Expanded(
            child: Center(
              child: Text('No Collections Yet',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonsWidget(),
    );
  }
}
