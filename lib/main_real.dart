import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/theme_manager.dart';
import 'themes/app_theme.dart';
import 'screens/login_screen.dart'; // Ensure this file exists with your TestPage class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Directly go to TestPage
    );
  }
}