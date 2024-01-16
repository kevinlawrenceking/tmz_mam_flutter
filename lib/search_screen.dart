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
  int limit = 10; // Number of items per page
  int offset = 0; // Starting offset

  Future<List<Inventory>> fetchInventory(int limit, int offset) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    List<Inventory> inventoryList =
        await apiService.fetchInventory(limit, offset);

    // Sorting is already handled in the Inventory.fromJson factory
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
                MaterialPageRoute(
                    builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                FutureBuilder<List<Inventory>>(
                  future: fetchInventory(limit, offset),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Container(
                        color: Colors.grey[850],
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: snapshot.data!
                              .map((inventoryItem) =>
                                  buildCard(context, inventoryItem))
                              .toList(),
                        ),
                      );
                    } else {
                      return Text('No data found');
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (offset >= limit) {
                            setState(() {
                              offset -= limit;
                            });
                          }
                        },
                      ),
                      Text('Page ${offset ~/ limit + 1}'),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            offset += limit;
                          });
                        },
                      ),
                    ],
                  ),
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
                width: isRightPanelOpen
                    ? MediaQuery.of(context).size.width * 0.25
                    : 0,
                color: Colors.grey[850],
                child: isRightPanelOpen
                    ? Center(child: Text('Right Panel Content'))
                    : null,
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
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ) ??
                                    TextStyle(fontWeight: FontWeight.bold),
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
