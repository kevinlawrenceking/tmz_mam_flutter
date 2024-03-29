import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/screens/account_settings_screen.dart';
import 'package:tmz_mam_flutter/services/api_service.dart'; // Import your API service
import 'package:tmz_mam_flutter/models/inventory.dart'; // Import your Inventory model
import 'package:tmz_mam_flutter/screens/details_screen.dart';
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/main_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/main_page_control_bar2_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import '../components/advanced_search_window_widget.dart';
import 'package:tmz_mam_flutter/themes/theme_provider.dart';

/// A screen that provides search functionality for photo assets within the TMZ Media Asset Manager.
///
/// This screen allows users to search for assets using various criteria, view search results in a grid format,
/// and access detailed information about each asset. It includes an advanced search drawer, toggleable theme,
/// and a bottom navigation bar for additional actions.

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  int limit = 10; // Number of items per page
  int offset = 0; // Starting offset

  void toggleTheme() {
    // Toggle the theme
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  void updateLimit(int newLimit) {
    setState(() {
      limit = newLimit;
    });
    fetchInventory(limit, offset);
  }

  Future<InventoryResponse> fetchInventory(int limit, int offset) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    // This should return InventoryResponse, not List<Inventory>
    InventoryResponse inventoryResponse =
        await apiService.fetchInventory(limit, offset);
    return inventoryResponse;
  }

  bool isRightPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TMZ Media Asset Manager', // Pass a String directly
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Use Provider to toggle the theme
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AccountSettingsScreen()));
            },
          ),
          // Additional actions can be added here
        ],
      ),
      drawer: const SizedBox(
        width: 900, // Set the drawer width
        child: AdvancedSearchWindowWidget(), // Place your widget here
        // You can also add color or decoration to the container if needed
        // For example, to add a background color:
        // color: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: SearchBarWidget(),
                ),
                const MainPageControlBarWidget(),
                MainPageControlBar2Widget(
                    updateLimitCallback:
                        updateLimit) // Pass the correct value here),
                ,
                FutureBuilder<InventoryResponse>(
                  future: fetchInventory(limit, offset),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        offset == 0) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final inventoryList = snapshot.data!.inventoryList;
                      final totalRecords = snapshot
                          .data!.totalRecords; // Update totalRecords here

                      return Column(
                        children: [
                          // Display totalRecords somewhere in your UI
                          Text('Total Records: $totalRecords'),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: buildGridContent(inventoryList),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data found'));
                    }
                  },
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isRightPanelOpen = !isRightPanelOpen;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isRightPanelOpen
                    ? MediaQuery.of(context).size.width * 0.25
                    : 0,
                color: Colors.grey[850],
                child: isRightPanelOpen
                    ? const Center(child: Text('Right Panel Content'))
                    : null,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomButtonsWidget(),
    );
  }

  Widget buildAdvancedSearchControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: () {}, child: const Text('Advanced Search')),
          Row(
            children: [
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: 'Last Updated',
                onChanged: (newValue) {},
                items: <String>[
                  'Last Updated',
                  'Created',
                  'Celebrity',
                  'Headline'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Switch(value: true, onChanged: (val) {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridContent(List<Inventory> data) {
    return Wrap(
      key: ValueKey<int>(offset),
      spacing: 8.0,
      runSpacing: 8.0,
      children: data
          .map((inventoryItem) => buildAnimatedCard(context, inventoryItem))
          .toList(),
    );
  }

  Widget buildAnimatedCard(BuildContext context, Inventory inventoryItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DetailsScreen(),
          ),
        );
      },
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: buildCard(context, inventoryItem),
      ),
    );
  }

  Widget buildCard(BuildContext context, Inventory inventoryItem) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5 - 16,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey,
              height: 180,
              child: Image.network(
                inventoryItem.thumbnail,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    inventoryItem.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(),
                  const SizedBox(height: 4),
                  ...inventoryItem.metadata.map((metadataItem) {
                    var label = metadataItem["metalabel"];
                    var value = metadataItem["metavalue"];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label ?? '',
                            style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ) ??
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            value ?? '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: SearchScreen()));
}
