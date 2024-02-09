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

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  int limit = 10;
  int offset = 0;
  String searchTerm = '';
  late Future<InventoryResponse> futureInventoryResponse;

  @override
  void initState() {
    super.initState();
    futureInventoryResponse =
        fetchInventory(); // Initialize futureInventoryResponse here
  }

  Future<InventoryResponse> fetchInventory() async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    return await apiService.fetchInventory(limit, offset,
        searchTerm: searchTerm);
  }

  void updateLimit(int newLimit) {
    setState(() {
      limit = newLimit;
      offset = 0; // Reset offset to start from the beginning with new limit
      futureInventoryResponse = fetchInventory(); // Re-fetch with new limit
    });
  }

  void loadMore() {
    setState(() {
      offset += limit; // Increase offset to fetch the next set of items
      futureInventoryResponse = fetchInventory(); // Re-fetch with new offset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'TMZ Media Asset Manager'),
      drawer: const SizedBox(width: 900, child: AdvancedSearchWindowWidget()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SearchBarWidget(
                  onSearchSubmit: (String term) {
                    setState(() {
                      searchTerm = term;
                      offset =
                          0; // Reset offset to start from the first page after search
                    });
                    fetchInventory();
                  },
                ),
                const MainPageControlBarWidget(),
                MainPageControlBar2Widget(updateLimitCallback: updateLimit),
                FutureBuilder<InventoryResponse>(
                  future: futureInventoryResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.hasData) {
                      final inventoryList = snapshot.data!.inventoryList;
                      final totalRecords = snapshot.data!.totalRecords;
                      return Column(
                        children: [
                          Text('Total Records: $totalRecords'),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: buildGridContent(inventoryList),
                          ),
                          if (inventoryList.length <
                              totalRecords) // Show load more button only if there are more items to load
                            ElevatedButton(
                              onPressed: loadMore,
                              child: Text('Load More'),
                            )
                        ],
                      );
                    }
                    return const Center(child: Text('No data found'));
                  },
                )
              ],
            ),
          ),
          // Additional UI elements...
        ],
      ),
      bottomNavigationBar: const BottomButtonsWidget(),
    );
  }

  // Build grid content and other helper methods...

  Widget buildGridContent(List<Inventory> inventoryList) {
    return Wrap(
      key: ValueKey<int>(
          offset), // Use offset as key to ensure widget rebuilds when offset changes
      spacing: 8.0,
      runSpacing: 8.0,
      children: inventoryList
          .map((inventoryItem) => buildAnimatedCard(context, inventoryItem))
          .toList(),
    );
  }

  Widget buildAnimatedCard(BuildContext context, Inventory inventoryItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                  inventoryItem:
                      inventoryItem)), // Make sure DetailsScreen accepts an Inventory item as a parameter
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
      width: MediaQuery.of(context).size.width / 5 -
          16, // Adjust the width as needed
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey,
              height: 180, // Adjust the height as needed
              child: Image.network(
                inventoryItem.thumbnail,
                fit: BoxFit.cover,
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
                    var label = metadataItem['metalabel'];
                    var value = metadataItem['metavalue'];
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
                                    ?.copyWith(fontWeight: FontWeight.bold) ??
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
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Perform any necessary cleanup
  }
}