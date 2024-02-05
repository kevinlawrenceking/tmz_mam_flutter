import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/ThemeProvider.dart'; // Import your ThemeProvider
import 'package:tmz_mam_flutter/screens/login_screen.dart'; // Import your LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Your App Title',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(), // Define your light theme here
            darkTheme: ThemeData.dark(), // Define your dark theme here
            themeMode: themeProvider.themeMode, // Use ThemeMode from ThemeProvider
            home: const LoginScreen(), // Set LoginScreen as the first screen
          );
        },
      ),
    );
  }
}
