import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart'; // Import ThemeManager
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure storage
import 'dart:convert';
import 'search_screen.dart';
import 'app_palette.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage(); // Instance of FlutterSecureStorage

  Future<void> sendLoginCredentials(String username, String password) async {
    var url = Uri.parse('http://tmztoolsdev:3000/login'); // Replace with your server's URL

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'apiKey': 'ec2d2742-834f-11ee-b962-0242ac120002', // Your API key
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true && responseData['message'] != null) {
          await storage.write(key: 'jwt_token', value: responseData['message']);
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          }
        } else {
          _showSnackBar('Login failed: Invalid credentials');
        }
      } else {
        _showSnackBar('Invalid password. Please try again.');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

    

Widget _buildLogoSection() {
  bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  String logoAsset = isDarkTheme ? 'assets/images/logo_dark.png' : 'assets/images/logo_light.png';
  return Expanded(
    flex: 1,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          child: Image.asset(logoAsset, fit: BoxFit.contain),
        ),
      ),
    ),
  );
}

Widget _buildLoginSection() {
  return Expanded(
    flex: 2,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            style: Theme.of(context).textTheme.titleMedium, // Use titleMedium style from theme
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: Theme.of(context).textTheme.titleMedium, // Use titleMedium style from theme
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String username = _usernameController.text;
              String password = _passwordController.text;
              if (username.isNotEmpty && password.isNotEmpty) {
                await sendLoginCredentials(username, password);
              } else {
                _showSnackBar('Please enter both username and password');
              }
            },
            child: Text('LOGIN'),
          ),
        ],
      ),
    ),
  );
}
 @override
    Widget build(BuildContext context) {
    // Determine the shadow color based on the theme brightness
    Color shadowColor = Theme.of(context).brightness == Brightness.dark 
                        ? AppPalette.darkThemeShadowColor 
                        : AppPalette.lightThemeShadowColor;
  return Scaffold(
    body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: shadowColor, // Adjust the color and opacity
              spreadRadius: 0,
              blurRadius: 10, // Adjust blur radius
              offset: Offset(0, 4), // Changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            _buildLogoSection(),
            _buildLoginSection(),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Provider.of<ThemeManager>(context, listen: false).toggleTheme();
      },
      child: Icon(Icons.brightness_4), // Icon for theme toggle
    ),
  );
}
}
