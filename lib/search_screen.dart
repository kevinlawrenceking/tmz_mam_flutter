
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart'; // Ensure this is correctly implemented
import 'app_palette.dart'; // Ensure this is your color palette file
import 'package:flutter/material.dart';
import 'account_settings_screen.dart'; // Import this if you have an AccountSettingsScreen

class SearchScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

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
            icon: Icon(Icons.account_circle), // Placeholder for user avatar
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
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
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: (16 / 9),
              ),
              itemCount: 20, // Adjust based on the number of items
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(color: Colors.grey), // Gray background
                            Image.network(
                              'https://via.placeholder.com/160x90', // Replace with actual image data
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Los Angeles Chargers vs Dallas Cowboys',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rights Summary: Free (Non-TMZ)',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'CreatedBy: xarene',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'Celebrity: Brandon Staley',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Pagination Controls Here'),
          ),
        ],
      ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use Provider to access ThemeManager and toggle the theme.
          Provider.of<ThemeManager>(context, listen: false).toggleTheme();
        },
        child: Icon(Icons.brightness_4), // Icon for theme toggle
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
