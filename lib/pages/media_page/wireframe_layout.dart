import 'package:flutter/material.dart';

class WireframeLayout extends StatelessWidget {
  const WireframeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of columns based on screen width
    int columns = (screenWidth > 600) ? 2 : 1;

    return Container(
      color: Colors.lightBlue, // Set the background color
      child: GridView.count(
        crossAxisCount: columns,
        children: <Widget>[
          // First cell with an image
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.network('your_image_url_here'),
          ),
          // Second cell with a card
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Metadata'),
                  ),
                  // Add other metadata content here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
