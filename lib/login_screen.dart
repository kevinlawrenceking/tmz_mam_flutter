import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure storage
import 'dart:convert';
import 'search_screen.dart';

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
          print('Login failed: ${response.body}');
        }
      } else {
        print('Server error: ${response.body}');
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
    ThemeData theme = Theme.of(context);
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
                filled: true,
                fillColor: theme.primaryColor, // Use theme color
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: theme.primaryColor, // Use theme color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                sendLoginCredentials(username, password);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.primaryColor), // Use theme color
              ),
              child: Text(
                'LOGIN',
                style: theme.textTheme.button, // Use text style from theme
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme background color
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Use theme primary color
            borderRadius: BorderRadius.circular(10),
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

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}


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
          print('Login failed: ${response.body}');
        }
      } else {
        print('Server error: ${response.body}');
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
    ThemeData theme = Theme.of(context);
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
                filled: true,
                fillColor: theme.primaryColor, // Use theme color
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: theme.primaryColor, // Use theme color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                sendLoginCredentials(username, password);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.primaryColor), // Use theme color
              ),
              child: Text(
                'LOGIN',
                style: theme.textTheme.button, // Use text style from theme
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme background color
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Use theme primary color
            borderRadius: BorderRadius.circular(10),
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

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}
