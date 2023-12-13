import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart'; // Import ThemeManager
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> sendLoginCredentials(String username, String password) async {
    var url = Uri.parse('http://tmztoolsdev:3000/login'); // Replace with your server's URL

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'apiKey': 'ec2d2742-834f-11ee-b962-0242ac120002', // Add your API key here
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('Login successful');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLogoSection() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
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
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                sendLoginCredentials(username, password);
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
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background, // Updated to use colorScheme.background
          ),
          child: Row(
            children: <Widget>[
              _buildLogoSection(),
              _buildLoginSection(),
            ],
          ),
        ),
      ),
    );
  }
}
