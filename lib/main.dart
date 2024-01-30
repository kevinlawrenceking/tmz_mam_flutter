import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/details.dart'; // Your ResponsiveLayout import
import 'package:tmz_mam_flutter/themeprovider.dart'; // Import your ThemeProvider
import 'package:tmz_mam_flutter/login_screen.dart'; // Import your ThemeProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Your App Title',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode, // Use ThemeMode from ThemeProvider
            home: LoginScreen(), // Directly go to TestPage
          );
        },
      ),
    );
  }
}
