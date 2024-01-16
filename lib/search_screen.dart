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

  Future<List<Inventory>> fetchInventory(int page) async {
    var apiService = ApiService(baseUrl: 'http://tmztoolsdev:3000');
    // Modify this method to fetch data based on the page index
    // This could involve calculating the offset based on the page number
    List<Inventory> inventoryList = await apiService.fetchInventory();

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
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
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
crossAxisCount: 3, // Adjust the number of columns as needed),
    itemCount: inventoryItems.length,
    itemBuilder: (context, index) {
      return buildCard(context, inventoryItems[index]);
    },
  );
}

Widget buildCard(BuildContext context, Inventory inventoryItem) {
// Build your individual item card here
return Container(
width: MediaQuery.of(context).size.width / 5 - 16, // Adjusted for 5 items per row
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
// Additional item details here
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