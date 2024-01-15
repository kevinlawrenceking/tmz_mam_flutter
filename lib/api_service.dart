import 'dart:convert';
import 'package:http/http.dart' as http;
import 'inventory.dart'; // Replace with the path to your Inventory model

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fetch inventory data from the API
  Future<List<Inventory>> fetchInventory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/inventory/light'),
        headers: {
          'Content-Type': 'application/json',
          'apiKey': 'ec2d2742-834f-11ee-b962-0242ac120002', // Your API key
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Inventory> inventory = body.map((dynamic item) => Inventory.fromJson(item)).toList();
        return inventory;
      } else {
        // Log the status code and response body for debugging
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
        throw Exception('Failed to load inventory. Status code: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      // Handle JSON format errors
      print('Format error: $e');
      throw Exception('Error occurred while decoding data: $e');
    } catch (e) {
      // Handle other exceptions
      print('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}
