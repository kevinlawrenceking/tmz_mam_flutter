import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search MAM'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {/* Account settings */}),
          // Add more icons if needed
        ],
        // Add logo and search box
      ),
      body: Column(
        children: <Widget>[
          // Utility bar goes here
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
      // Implement drawers for sidebars if needed
    );
  }
}
