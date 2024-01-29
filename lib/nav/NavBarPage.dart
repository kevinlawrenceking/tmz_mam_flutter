import 'package:flutter/material.dart';

class NavBarPage extends StatefulWidget {
  final String? initialPage;
  final Widget? page;

  const NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    // Implement your bottom navigation bar and page view logic here
    return Scaffold(
      appBar: AppBar(
        title: Text('NavBarPage'),
      ),
      body: Center(
        child: _currentPage ?? Text('Page not found'),
      ),
    );
  }
}
