import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/login_screen.dart';
import 'app_theme.dart';
import 'theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: context.watch<ThemeManager>().themeMode,
        debugShowCheckedModeBanner: false,
        home: LoginScreen(), // Use TestScreen here
      ),
    );
  }
}
