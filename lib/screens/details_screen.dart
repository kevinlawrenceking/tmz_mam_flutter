// Import necessary Flutter packages

// ignore_for_file: deprecated_member_use_from_same_package, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/themes/theme_provider.dart'; // Ensure the path is correct
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/components/metadata_update_form_widget.dart'; // Ensure this is the correct path to your MetadataUpdateFormWidget

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  void toggleTheme(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'TMZ Media Asset Manager',
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => toggleTheme(context),
          ),
          // Additional actions can be added here
        ],
      ),
      endDrawer: Drawer(
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.75, // Custom width: 75% of screen width
          child:
              const MetadataUpdateFormWidget(), // Your widget inside the drawer
        ),
      ),
      body: isDesktop ? const DesktopLayout() : const MobileLayout(),
    );
  }
}

// DesktopLayout for wider screens
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarWidget(), // Search bar component
        const MediaPageControlBarWidget(), // Toolbar component

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: FlutterFlowTheme.of(context)
                .secondaryText, // Make sure FlutterFlowTheme is correctly imported
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Tallz Grass Blowing in the Wind',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).headlineLarge,
                ),
              ),
              Text(
                'Categories: Specials, TV',
                style: FlutterFlowTheme.of(context).bodyLarge,
              ),
            ],
          ),
        ),

// Generated code for this Text Widget...
        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text(
              'Appers In: Collection 1, Collection 36',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
        ),

        const Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageContainer(),
              ),
              Expanded(
                child: MetadataContainer(),
              ),
            ],
          ),
        ),
        const PhotoInfoContainer(),
        const BottomButtonsWidget(),
      ],
    );
  }
}

// MobileLayout for narrower screens
class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchBarWidget(), // Search bar component
        MediaPageControlBarWidget(), // Toolbar component
        ImageContainer(),
        PhotoInfoContainer(),
        MetadataContainer(),
      ],
    );
  }
}

// ImageContainer widget with background color matching the MetadataContainer
class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlutterFlowTheme.of(context)
          .secondaryBackground, // Matches the MetadataContainer background
      child: AspectRatio(
        aspectRatio: 16 / 9, // Maintain a 16:9 aspect ratio for the image
        child: Container(
          decoration: const BoxDecoration(
              // Inner color for the aspect ratio area
              ),
          child: Image.asset(
            'assets/images/test.jpg',
            fit: BoxFit
                .contain, // Image fits within the container while maintaining its aspect ratio
          ),
        ),
      ),
    );
  }
}

// PhotoInfoContainer widget
class PhotoInfoContainer extends StatelessWidget {
  const PhotoInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the container take full width
      padding: const EdgeInsets.all(8), // Padding around the entire container
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11, // Smaller font size
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11, // Smaller font size
          ),
        ),
      ],
    );
  }
}

// MetadataContainer widget
class MetadataContainer extends StatelessWidget {
  const MetadataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
      color: FlutterFlowTheme.of(context)
          .secondaryBackground, // Specific background color
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Container(
          height: 435,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                        child: Text(
                          'Metadata',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleLargeFamily),
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
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
                      // ignore: deprecated_member_use_from_same_package
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Associated Celebrity',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ),
                    Text(
                      'Not applicable',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Shot Description',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ),
                    Text(
                      'NEW YORK, NEW YORK - DECEMBER 06: Alec Baldwin speaks onstage during the Robert F. Kennedy Human Rights\' 2023 Ripple of Hope Gala on December 06, 2023 in New York City. (Photo by Mike Coppola/Getty Images for Robert F. Kennedy Human Rights)',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Rights Summary',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ),
                    Text(
                      'Free (Non-TMZ)',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Rights Details',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ),
                    Text(
                      'Getty-1234567',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Credit',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
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
