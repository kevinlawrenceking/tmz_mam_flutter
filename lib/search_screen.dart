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
  final PageController _pageController = PageController();
  int currentPage = 0;
  int totalNumberOfPages = 10; // Example total number of pages
  int limit = 10; // Number of items per page

  Future<List<Inventory>> fetchInventory(int page) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    int offset = page * limit; // Calculate the offset based on the page number
    List<Inventory> inventoryList =
        await apiService.fetchInventory(limit, offset);

    return inventoryList;
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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalNumberOfPages,
              itemBuilder: (context, index) {
                return FutureBuilder<List<Inventory>>(
                  future: fetchInventory(index),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return buildPage(snapshot.data!);
                    } else {
                      return Text('No data found');
                    }
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      currentPage--;
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (currentPage < totalNumberOfPages - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      currentPage++;
                    });
                  }
                },
              ),
            ],
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

  Widget buildPage(List<Inventory> inventoryItems) {
    // Build your grid or list view here using inventoryItems
    // For instance, using a GridView.builder
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust the number of columns as needed
      ),
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        return buildCard(context, inventoryItems[index]);
      },
    );
  }

  Widget buildCard(BuildContext context, Inventory inventoryItem) {
    return Container(
      width: MediaQuery.of(context).size.width / 6 -
          16, // Adjusted for 6 items per row
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              // Making the image container flexible
              child: Container(
                color: Colors.grey,
                child: Image.network(
                  inventoryItem.thumbnail,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoryItem.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(),
                  ...inventoryItem.metadata.map((metadataItem) {
                    var label = metadataItem["metalabel"];
                    var value = metadataItem["metavalue"];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label ?? '', // Provide a default empty string
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ) ??
                                    TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            value ??
                                '-', // Provide a default '-' when value is null
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

  void main() {
    runApp(MaterialApp(home: SearchScreen()));
  }
}
