import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/themes/theme_provider.dart'; // Ensure the path is correct
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_old_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/components/metadata_update_form_widget.dart';
import 'package:tmz_mam_flutter/models/InventoryDetail.dart';

class DetailsScreen extends StatelessWidget {
  final InventoryDetail inventoryDetail; // Add InventoryDetail object

  const DetailsScreen({super.key, required this.inventoryDetail}); // Modify constructor to accept inventoryDetail

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
      body: isDesktop ? DesktopLayout(inventoryDetail: inventoryDetail) : MobileLayout(inventoryDetail: inventoryDetail), // Pass inventoryDetail to layouts
    );
  }
}

// Adjust DesktopLayout and MobileLayout similarly as shown below for DesktopLayout

// DesktopLayout for wider screens
class DesktopLayout extends StatelessWidget {
  final InventoryDetail inventoryDetail; // Add InventoryDetail object

  const DesktopLayout({super.key, required this.inventoryDetail}); // Modify constructor to accept inventoryDetail

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarOldWidget(), // Search bar component
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
                  inventoryDetail.name, // Use inventoryDetail object
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).headlineLarge,
                ),
              ),
              Text(
                inventoryDetail.categoryDisplay, // Use inventoryDetail object
                style: FlutterFlowTheme.of(context).bodyLarge,
              ),
            ],
          ),
        ),

        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text(
              inventoryDetail.collectionDisplay, // Use inventoryDetail object
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
                child: MetadataContainer(metadata: inventoryDetail.metadata), // Pass metadata to MetadataContainer
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

// Update MetadataContainer to accept metadata and loop over it

// MetadataContainer widget
class MetadataContainer extends StatelessWidget {
  final List<Metadata> metadata; // Add metadata list

  const MetadataContainer({super.key, required this.metadata}); // Modify constructor to accept metadata

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
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                      child: Text(
                        'Metadata',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: metadata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(metadata[index].metalabel),
                          subtitle: Text(metadata[index].metavalue),
                        );
                      },
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
