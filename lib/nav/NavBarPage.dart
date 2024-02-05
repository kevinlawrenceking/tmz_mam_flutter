// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavBarPage extends StatefulWidget {
  final String? initialPage;
  final Widget? page;

  const NavBarPage({super.key, this.initialPage, this.page});

  @override
  NavBarPageState createState() => NavBarPageState();
}

class NavBarPageState extends State<NavBarPage> {
  String currentPageName = 'HomePage';
  late Widget? currentPage;

  @override
  void initState() {
    super.initState();
    currentPageName = widget.initialPage ?? currentPageName;
    currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    // Implement your bottom navigation bar and page view logic here
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavBarPage'),
      ),
      body: Center(
        child: currentPage ?? const Text('Page not found'),
      ),
    );
  }
}
