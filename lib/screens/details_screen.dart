import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/models/inventory.dart'; // Make sure to import your Inventory model
import 'package:tmz_mam_flutter/themes/theme_provider.dart';
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_old_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/components/metadata_update_form_widget.dart';

class DetailsScreen extends StatelessWidget {
  final Inventory inventoryItem;

  const DetailsScreen({Key? key, required this.inventoryItem})
      : super(key: key);

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
      body: isDesktop
          ? DesktopLayout(inventoryItem: inventoryItem)
          : MobileLayout(inventoryItem: inventoryItem),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final Inventory inventoryItem;

  const DesktopLayout({Key? key, required this.inventoryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your desktop layout using the inventoryItem
    return Center(
        child: Text('Desktop Layout - ${inventoryItem.name}')); // Placeholder
  }
}

class MobileLayout extends StatelessWidget {
  final Inventory inventoryItem;

  const MobileLayout({Key? key, required this.inventoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your mobile layout using the inventoryItem
    return Center(
        child: Text('Mobile Layout - ${inventoryItem.name}')); // Placeholder
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your image container
    return Container(); // Make sure to replace this with your actual widget
  }
}

class PhotoInfoContainer extends StatelessWidget {
  const PhotoInfoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your photo info container
    return Container(); // Make sure to replace this with your actual widget
  }
}

class MetadataContainer extends StatelessWidget {
  const MetadataContainer({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // Implement your metadata container
    return Container(); // Make sure to replace this with your actual widget
  }

  
}

