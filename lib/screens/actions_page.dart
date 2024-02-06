import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/themes/theme_provider.dart'; // Import your ThemeProvider
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';

class ActionsPage extends StatefulWidget {
  final String title;

  const ActionsPage({super.key, required this.title});

  @override
  ActionsPageState createState() => ActionsPageState();
}

class ActionsPageState extends State<ActionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TMZ Media Asset Manager',
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Use Provider to toggle the theme
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          // Other actions can be added here
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Coming soon!', // Updated subheading text
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            // You can add more widgets here as needed
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomButtonsWidget(), // Added BottomButtonsWidget here
    );
  }
}
