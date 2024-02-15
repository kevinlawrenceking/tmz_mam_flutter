import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/services/api_service.dart'; // Import ApiService
import 'package:tmz_mam_flutter/models/inventory_detail.dart'; // Import inventoryDetail model
import 'package:tmz_mam_flutter/themes/theme_provider.dart';
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_old_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/components/metadata_update_form_widget.dart';

class DetailsScreen extends StatefulWidget {
  final int inventoryId;

  const DetailsScreen({super.key, required this.inventoryId});

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  late Future<InventoryDetail> futureinventoryDetail;

  @override
  void initState() {
    super.initState();
    futureinventoryDetail = ApiService(baseUrl: "http://tmztoolsdev:3000")
        .fetchinventoryDetailById(widget.inventoryId);
  }

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
        ],
      ),
      endDrawer: Drawer(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: const MetadataUpdateFormWidget(),
        ),
      ),
      body: FutureBuilder<InventoryDetail>(
        future: futureinventoryDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }
          final inventoryDetail = snapshot.data!;
          return isDesktop
              ? DesktopLayout(inventoryDetail: inventoryDetail)
              : MobileLayout(inventoryDetail: inventoryDetail);
        },
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final inventoryDetail;

  const DesktopLayout({super.key, required this.inventoryDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarOldWidget(),
        MediaPageControlBarWidget(
            imageUrl: inventoryDetail.source), // Pass the image URL here

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: FlutterFlowTheme.of(context).secondaryText),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  inventoryDetail.name,
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).headlineLarge,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Categories: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: inventoryDetail.categoryDisplay,
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Appears In: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.black), // Adjust color as needed
                  ),
                  TextSpan(
                    text: inventoryDetail.collectionDisplay,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black), // Adjust color as needed
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageContainer(source: inventoryDetail.source),
              ),
              Expanded(
                child: MetadataContainer(metadata: inventoryDetail.metadata),
              ),
            ],
          ),
        ),
        PhotoInfoContainer(inventoryDetail: inventoryDetail),
        const BottomButtonsWidget(currentScreen: 'Assets'),
      ],
    );
  }
}

// MobileLayout, ImageContainer, PhotoInfoContainer, MetadataContainer classes remain the same as your provided code.

// MobileLayout for narrower screens
class MobileLayout extends StatelessWidget {
  final inventoryDetail;

  const MobileLayout({super.key, required this.inventoryDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarOldWidget(),
        MediaPageControlBarWidget(imageUrl: inventoryDetail.source),
        ImageContainer(source: inventoryDetail.source),
        PhotoInfoContainer(inventoryDetail: inventoryDetail),
        MetadataContainer(metadata: inventoryDetail.metadata),
      ],
    );
  }
}

// ImageContainer widget with background color matching the MetadataContainer
class ImageContainer extends StatelessWidget {
  final String source; // Use this to pass the image URL

  const ImageContainer({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    final bool isValidUrl = Uri.tryParse(source)?.isAbsolute ?? false;
    return Padding(
      padding: const EdgeInsets.all(
          20.0), // This adds padding around the entire container
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, // Background color
            border: Border.all(
                color: Colors.black,
                width: 0.1), // Very thin border around the image
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Subtle shadow color
                spreadRadius: 2,
                blurRadius: 12,
                offset:
                    const Offset(4, 4), // Shadow position for elevation effect
              ),
            ]),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: isValidUrl
              ? Image.network(
                  source,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle loading error, e.g., by showing a placeholder or an error message
                    return Center(
                        child: Text(
                            'No image available\n$source')); // Show the invalid URL
                  },
                )
              : Center(
                  child: Text(
                      'Invalid image URL\n$source')), // Show the invalid URL
        ),
      ),
    );
  }
}

// PhotoInfoContainer widget
class PhotoInfoContainer extends StatelessWidget {
  final inventoryDetail;

  const PhotoInfoContainer({super.key, required this.inventoryDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(20), // Outer padding for the entire container
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .secondaryBackground, // Background color
          border: Border.all(color: Colors.black, width: 0.1), // Thin border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              // Customized shadow color
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(4, 4), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 100,
            runSpacing: 0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              infoColumn(context, 'ID', inventoryDetail.id.toString()),
              infoColumn(
                  context, 'Original File Name', inventoryDetail.fileName),
              infoColumn(
                  context, 'createdBy', inventoryDetail.createdByDisplay),
              infoColumn(context, 'Created', inventoryDetail.dateCreated),
              infoColumn(context, 'Updated', inventoryDetail.dateUpdated),
              infoColumn(context, 'Status', inventoryDetail.status),
            ],
          ),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}

// MetadataContainer widget with the same style as the ImageContainer
class MetadataContainer extends StatelessWidget {
  final List<Metadata> metadata;

  const MetadataContainer({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(20.0), // Outer padding for the entire container
      child: Container(
        decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context)
                .secondaryBackground, // Background color
            border: Border.all(color: Colors.black, width: 0.1), // Thin border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Subtle shadow color
                spreadRadius: 2,
                blurRadius: 12,
                offset:
                    const Offset(4, 4), // Shadow position for elevation effect
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding for the title
              child: Text(
                'Metadata',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge, // Style for the title
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: metadata
                      .map((meta) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meta.metalabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium, // Style for metalabel
                                ),
                                Text(
                                  meta.metavalue, // Assuming metavalue could be null
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Style for metavalue
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
