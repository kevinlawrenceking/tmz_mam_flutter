import 'package:flutter/material.dart';
import 'inventory.dart'; // Import your Inventory model

class DetailsScreen extends StatelessWidget {
  final int id;
  final Inventory inventoryItem; // Assuming you pass the whole inventory item

  DetailsScreen({required this.id, required this.inventoryItem});

@override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: Text('Details for ${inventoryItem.name}'),
        bottom: TabBar(
          labelColor: Colors.white, // Set the color of the text of the selected tab
          unselectedLabelColor: Colors.white60, // Color of the unselected tabs
          tabs: [
            Tab(text: "Asset Info"),
            Tab(text: "Metadata"),
            Tab(text: "Usage"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1, // Adjust the ratio of image section to tab section
            child: Image.network(
              inventoryItem.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2, // Adjust as needed
            child: TabBarView(
              children: [
                buildAssetInfoTab(),
                buildMetadataTab(),
                buildUsageTab(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget buildAssetInfoTab() {
    // Populate with asset info
    return Center(child: Text("Asset Info Content"));
  }

  Widget buildMetadataTab() {
    // Populate with metadata
    return ListView(
      children: inventoryItem.metadata.map((metadataItem) {
        var label = metadataItem["metalabel"] ?? '';
        var value = metadataItem["metavalue"] ?? '-';
        return ListTile(
          title: Text(label),
          subtitle: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildUsageTab() {
    // Populate with usage info
    return Center(child: Text("Usage Content"));
  }
}