import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';
import 'app_palette.dart';
import 'account_settings_screen.dart';
import 'api_service.dart'; // Import your API service
import 'inventory.dart'; // Import your Inventory model

class SearchScreen extends StatelessWidget {
  Future<List<Inventory>> fetchInventory() async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    return apiService.fetchInventory(); // Replace with actual method
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
              future: fetchInventory(),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Pagination Controls Here'),
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



void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
