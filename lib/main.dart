import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';
import 'app_theme.dart';
import 'login_screen.dart'; // Ensure this file exists with your TestPage class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Directly go to TestPage
    );
  }
}
