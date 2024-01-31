import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/themeprovider.dart'; // Ensure correct path
import 'account_settings_screen.dart';
import 'api_service.dart'; // Import your API service
import 'inventory.dart'; // Import your Inventory model
import 'details.dart';
import 'components/custom_app_bar.dart';
import 'components/search_bar_widget.dart';
import 'components/main_page_control_bar_widget.dart';
import 'components/main_page_control_bar2_widget.dart';
import 'components/bottom_buttons_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '/advanced_search_window_widget.dart';
class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int limit = 10; // Number of items per page
  int offset = 0; // Starting offset

    void updateLimit(int newLimit) {
    setState(() {
      limit = newLimit;
    });
    fetchInventory(limit, offset);
  }

Future<InventoryResponse> fetchInventory(int limit, int offset) async {
  var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
  // This should return InventoryResponse, not List<Inventory>
  InventoryResponse inventoryResponse = await apiService.fetchInventory(limit, offset);
  return inventoryResponse;
}


  bool isRightPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = 9999; // Adjust this value as needed

    return Scaffold(
      appBar: CustomAppBar(
  title: 'TMZ Media Asset Manager', // Pass a String directly
  actions: [
    IconButton(
      icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Use Provider to toggle the theme
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
    ),
    IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountSettingsScreen()));
      },
    ),
    // Additional actions can be added here
        ],
      ),
    
drawer: Container(
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
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SearchBarWidget(),
                ),
                MainPageControlBarWidget(),
                MainPageControlBar2Widget(updateLimitCallback: updateLimit),
                // More content will follow in the next part
                // Continuing from the FutureBuilder...
   FutureBuilder<InventoryResponse>(
  future: fetchInventory(limit, offset),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting && offset == 0) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      // Access the inventory list from the InventoryResponse
      final inventoryList = snapshot.data!.inventoryList;

      // Use inventoryList to build your UI
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: buildGridContent(inventoryList),
      );
    } else {
      return Center(child: Text('No data found'));
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
                duration: Duration(milliseconds: 300),
                width: isRightPanelOpen ? MediaQuery.of(context).size.width * 0.25 : 0,
                color: Colors.grey[850],
                child: isRightPanelOpen ? Center(child: Text('Right Panel Content')) : null,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonsWidget(),
    );
  }

Widget buildAdvancedSearchControls() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: () {}, child: Text('Advanced Search')),
          Row(
            children: [
              



              SizedBox(width: 8),





              DropdownButton<String>(
                value: 'Last Updated',
                onChanged: (newValue) {},
                items: <String>['Last Updated', 'Created', 'Celebrity', 'Headline']
                    .map<DropdownMenuItem<String>>((String value) {
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
    children: data.map((inventoryItem) => buildAnimatedCard(context, inventoryItem)).toList(),
  );
}

Widget buildAnimatedCard(BuildContext context, Inventory inventoryItem) {
  return GestureDetector(
  onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>   DetailsScreen(),
        ),
      );
    },
    child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 300),
        child: buildCard(context, inventoryItem),
      ),
    );
  }

  Widget buildCard(BuildContext context, Inventory inventoryItem) {
    return Container(
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
              padding: EdgeInsets.all(8.0),
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
                  Divider(),
                  SizedBox(height: 4),
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
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ) ?? TextStyle(fontWeight: FontWeight.bold),
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
}


void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
