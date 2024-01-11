import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';
import 'account_settings_screen.dart';
import 'api_service.dart'; // Import your API service
import 'inventory.dart'; // Import your Inventory model

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Inventory>> fetchInventory() async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    List<Inventory> inventoryList = await apiService.fetchInventory(); // Replace with actual method

    // Sort metadata for each inventory item
    for (var item in inventoryList) {
      item.sortMetadata();
    }

    return inventoryList;
  }

  bool isRightPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMZ Media Asset Manager'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Left Panel content here
        child: Center(child: Text('Left Panel Content')),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                FutureBuilder<List<Inventory>>(
                  future: fetchInventory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Container(
                        color: Colors.grey[850], // Dark grey background
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: snapshot.data!.map((inventoryItem) => buildCard(context, inventoryItem)).toList(),
                        ),
                      );
                    } else {
                      return Text('No data found');
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Pagination Controls Here'),
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
                color: Colors.grey[850], // Dark grey background for the right panel
                // Right Panel content here
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
    );
  }

  Widget buildCard(BuildContext context, Inventory inventoryItem) {
    return Container(
      width: MediaQuery.of(context).size.width / 6 - 16,
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
                  Divider(), // Horizontal line after the title
                  SizedBox(height: 4),
                  ...inventoryItem.metadata.map((metadataItem) {
                    var label = metadataItem.keys.first;
                    var value = metadataItem[label];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
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
