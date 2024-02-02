import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeprovider.dart'; // Import your ThemeProvider
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'metadata_update_form_widget.dart'; // Adjust the import path as needed

class DetailsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      key: _scaffoldKey, // Use the GlobalKey for Scaffold
      appBar: CustomAppBar(
        title: 'TMZ Media Asset Manager',
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Use Provider to toggle the theme
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit), // Pencil icon for editing metadata
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
          // Other actions can be added here
        ],
      ),
      drawer: Drawer(
        child: MetadataUpdateFormWidget(), // Drawer content
      ),
      body: isDesktop ? DesktopLayout() : MobileLayout(),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(), // Search bar component
        MediaPageControlBarWidget(), // Toolbar component
        // Additional UI components...
        Expanded(
          child: Row(
            children: [
              ImageContainer(),
              MetadataContainer(),
            ],
          ),
        ),
        BottomButtonsWidget(),
      ],
    );
  }
}

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(), // Search bar component
        MediaPageControlBarWidget(), // Toolbar component
        // Additional UI components...
        ImageContainer(),
        BottomButtonsWidget(),
      ],
    );
  }
}

 
// ImageContainer widget with background color matching the MetadataContainer
class ImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlutterFlowTheme.of(context).secondaryBackground, // Matches the MetadataContainer background
      child: AspectRatio(
        aspectRatio: 16 / 9, // Maintain a 16:9 aspect ratio for the image
        child: Container(
          decoration: BoxDecoration(
           // Inner color for the aspect ratio area
          ),
          child: Image.asset(
            'assets/images/test.jpg',
            fit: BoxFit.contain, // Image fits within the container while maintaining its aspect ratio
          ),
        ),
      ),
    );
  }
}
// PhotoInfoContainer widget
class PhotoInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the container take full width
      padding: EdgeInsets.all(8), // Padding around the entire container
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          spacing: 100, // Horizontal space between columns
          runSpacing: 0, // Vertical space between rows
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            infoColumn(context, 'ID', '2564104'),
            infoColumn(context, 'Original File Name', '1836307089.jp'),
            infoColumn(context, 'CreatedBy', 'MawhinneEl'),
            infoColumn(context, 'Created', '2024-01-19 at 11:26:16 AM'),
            infoColumn(context, 'Updated', '2024-01-19 at 11:26:27 AM'),
            infoColumn(context, 'Status', 'Available'),
          ],
        ),
      ),
    );
  }

Widget infoColumn(BuildContext context, String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11, // Smaller font size
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11, // Smaller font size
          ),
        ),
      ],
    );
  }
}

// MetadataContainer widget
class MetadataContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
  color: FlutterFlowTheme.of(context).secondaryBackground, // Specific background color
      child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    child: Container(
      height: 435,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, -1),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20,0, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Text(
                      'Metadata',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context)
                                    .titleLargeFamily),
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Text(
                    'Celebrity',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyLargeFamily,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyLargeFamily),
                        ),
                  ),
                ),
                Text(
                  'Not applicable',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Associated Celebrity',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                  ),
                ),
                Text(
                  'Not applicable',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                  ),
                ),
                Text(
                  'NEW YORK, NEW YORK - DECEMBER 06: Alec Baldwin speaks onstage during the Robert F. Kennedy Human Rights\' 2023 Ripple of Hope Gala on December 06, 2023 in New York City. (Photo by Mike Coppola/Getty Images for Robert F. Kennedy Human Rights)',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                  ),
                ),
                Text(
                  'Free (Non-TMZ)',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Rights Details',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                  ),
                ),
                Text(
                  'Getty-1234567',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                  ),
                ),
                Text(
                  'Getty',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
    );
  }
}
