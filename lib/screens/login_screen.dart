import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'search_screen.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<void> sendLoginCredentials(String username, String password) async {
    var url = Uri.parse(
        'http://tmztoolsdev:3000/login'); // Update with your actual URL

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
        if (responseData['success'] == true &&
            responseData['message'] != null) {
          await storage.write(key: 'jwt_token', value: responseData['message']);
          if (mounted) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  const SearchScreen(), // No need for toggleTheme parameter
            ));
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
    String logoAsset = isDarkTheme
        ? 'assets/images/logo_light.png'
        : 'assets/images/logo_light.png';
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SizedBox(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium, // Use titleMedium style from theme
              decoration: InputDecoration(
                labelText: 'Username',
                // Corrected usage of FlutterFlowTheme for labelStyle
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context)
                      .secondaryText, // Make sure this color is suitable for both light and dark themes
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium, // Use titleMedium style from theme
              decoration: InputDecoration(
                labelText: 'Password',
                // Here you can also use FlutterFlowTheme if needed, similar to the username field
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context)
                      .secondaryText, // Ensuring color is suitable for both themes
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;
                if (username.isNotEmpty && password.isNotEmpty) {
                  await sendLoginCredentials(username, password);
                } else {
                  _showSnackBar('Please enter both username and password');
                }
              }, // Set the text color to white
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context)
                    .primary, // Button background color
                foregroundColor: Colors
                    .white, // Text color (not needed if you've set it in Text's style)
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Adjust padding as needed
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors
                          .white, // Ensure text color is white for visibility
                      // Other text style properties if needed
                    ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Adjust border radius as needed
                ),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the shadow color based on the theme brightness
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      // You can customize your dark theme further
      // For example, using colors from FlutterFlowTheme
      primaryColor: FlutterFlowTheme.of(context)
          .primary, // Assuming your FlutterFlowTheme has a 'primary' color defined for dark mode
      // Define other properties as needed
    );

    return Theme(
        data: darkTheme, // Use the dark theme for this screen
        child: Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: FlutterFlowTheme.of(context)
                        .shadowColor, // Use shadowColor from the theme
                    spreadRadius: 0,
                    blurRadius: 0, // Adjust blur radius as needed
                    offset:
                        const Offset(0, 0), // Adjust the position of the shadow
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
        ));
  }
}
