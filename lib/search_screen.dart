import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';
import 'app_palette.dart';
import 'account_settings_screen.dart';

class SearchScreen extends StatelessWidget {
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
            Wrap(
              spacing: 8.0, // horizontal spacing between cards
              runSpacing: 8.0, // vertical spacing between cards
              children: List.generate(20, (index) => buildCard(context)),
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
        child: Icon(Icons.brightness_4), // Icon for theme toggle
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 16, // Adjust width as needed
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey, // Gray background
              height: 180, // Fixed height for image section
              child: Image.network(
                'http://tmztools.tmz.local/mediaroot/flutter/raw.jpg',
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
                    'Los Angeles Chargers vs Dallas Cowboys',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rights Summary: Free (Non-TMZ)',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'CreatedBy: xarene',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Celebrity: Brandon Staley',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Celebrity: Brandon Staley',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Celebrity: Brandon Staley',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  // Additional metadata rows
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
