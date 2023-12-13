// File: lib/test_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart'; // Import ThemeManager

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the theme data
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Testing Theme',
              style: theme.textTheme.headlineMedium, // Using text theme
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => 
                Provider.of<ThemeManager>(context, listen: false).themeMode = ThemeMode.light,
              child: Text('Light Theme'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => 
                Provider.of<ThemeManager>(context, listen: false).themeMode = ThemeMode.dark,
              child: Text('Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
