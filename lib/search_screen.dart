import 'package:flutter/material.dart';
import 'app_palette.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4a4a4a), // The background color
        elevation: 0, // Removes the shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo_trans.png'), // Your logo asset
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle), // Placeholder for user avatar
            onPressed: () {
              // TODO: Implement user profile navigation
            },
          ),
        ],
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search MAM',
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
          // TODO: Add search functionality
        ),
      ),
      body: Column(
        children: <Widget>[
          // Top search bar and navigation menu
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Color(0xFF4a4a4a),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                navItem('Images', context),
                navItem('Collections', context),
                navItem('Status', context),
                navItem('Admin', context),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: GridView.builder(
              // Grid builder to build asset cards
              itemCount: 20, // Placeholder for number of assets
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Adjust number of columns
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  // Card layout for assets goes here
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // Footer goes here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {/* Technical support */},
              child: Text('TECHNICAL SUPPORT'),
            ),
            TextButton(
              onPressed: () {/* Metadata support */},
              child: Text('METADATA SUPPORT'),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(String title, BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Add navigation functionality
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SearchScreen()));
}
