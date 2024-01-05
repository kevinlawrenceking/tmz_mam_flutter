import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';
import 'account_settings_screen.dart';
import 'api_service.dart'; // Import your API service
import 'Inventory.dart'; // Import your Inventory model

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int currentPage = 0;
  final int limit = 50; // Number of items per page
  List<Inventory> inventoryItems = [];

  Future<List<Inventory>> fetchInventory(int offset) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    var fetchedItems = await apiService.fetchInventory(offset: offset, limit: limit);
    setState(() {
      inventoryItems = fetchedItems;
    });
    return fetchedItems;
  }

  @override
  void initState() {
    super.initState();
    fetchInventory(0); // Initially fetch the first page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMZ Media Asset Manager'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Implement functionality to show the menu
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
      body: SingleChildScrollView(
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
              future: fetchInventory(currentPage * limit),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: snapshot.data!.map((inventoryItem) => buildCard(context, inventoryItem)).toList(),
                  );
                } else {
                  return Text('No data found');
                }
              },
            ),
            // Pagination controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: currentPage > 0 ? () => changePage(currentPage - 1) : null,
                ),
                Text('Page ${currentPage + 1}'),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => changePage(currentPage + 1),
                ),
              ],
            ),
          ],
        ),
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
      width: MediaQuery.of(context).size.width / 4 - 16,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey,
              height: 180,
              child: Image.network(
                inventoryItem.thumbnail ?? 'Unknown',
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
  inventoryItem.name ?? 'Unknown', // Provide a default value if name is null
  style: Theme.of(context).textTheme.titleMedium,
),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(value ?? '-')
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

  void changePage(int page) {
    int offset = page * limit;
    fetchInventory(offset);
    setState(() {
      currentPage = page;
    });
  }
}

void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
