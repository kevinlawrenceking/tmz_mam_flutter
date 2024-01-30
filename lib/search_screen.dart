import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'account_settings_screen.dart';
import 'api_service.dart'; // Import your API service
import 'inventory.dart'; // Import your Inventory model

import 'package:tmz_mam_flutter/details.dart';

import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/main_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/main_page_control_bar2_widget.dart';



import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';




class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  ThemeMode get themeMode => _themeMode;

  // Toggles the theme between light and dark mode
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify all listeners about the theme change
  }
}


class _SearchScreenState extends State<SearchScreen> {
  int limit = 10; // Number of items per page
  int offset = 0; // Starting offset

  Future<List<Inventory>> fetchInventory(int limit, int offset) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    List<Inventory> inventoryList =
        await apiService.fetchInventory(limit, offset);
    return inventoryList;
  }

  bool isRightPanelOpen = false;

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TMZ Media Asset Manager',
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeManager>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
          // Add more actions if needed
        ],
      ),
      drawer: Drawer(
        child: Center(child: Text('Left Panel Content')),
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

buildAdvancedSearchControls(), 
 MainPageControlBarWidget(),
 MainPageControlBar2Widget(),
 // Advanced search controls
                FutureBuilder<List<Inventory>>(
                  future: fetchInventory(limit, offset),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting && offset == 0) {
                      // Show spinner only during initial load
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: buildGridContent(snapshot.data!),
                      );
                    } else {
                      // Show a placeholder or message if no data is found
                      return Center(child: Text('No data found'));
                    }
                  },
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeManager>(context, listen: false).toggleTheme();
        },
        child: Icon(Icons.brightness_4),
      ),

      
    bottomNavigationBar: BottomButtonsWidget(), // Adding BottomButtonsWidget here
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
              DropdownButton<int>(
                value: limit,
                onChanged: (newLimit) {
                  if (newLimit != null) {
                    setState(() {
                      limit = newLimit;
                    });
                  }
                },
                items: [10, 25, 50, 100, 250, 500].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
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
      key: ValueKey<int>(offset), // Unique key for AnimatedSwitcher
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
            builder: (context) =>   DetailsScreen(toggleTheme: () { 'dark'; },),
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