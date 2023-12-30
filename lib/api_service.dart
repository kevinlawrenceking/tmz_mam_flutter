import 'dart:convert';
import 'package:http/http.dart' as http;
import 'inventory.dart'; // Replace with the path to your Inventory model

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fetch inventory data from the API
  Future<List<Inventory>> fetchInventory() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/inventory')); // Adjust the URL path as needed

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Inventory> inventory = body.map((dynamic item) => Inventory.fromJson(item)).toList();
        return inventory;
      } else {
        // Handle the case when the server returns a 4xx or 5xx response
        throw Exception('Failed to load inventory');
      }
    } catch (e) {
      // Handle any exceptions thrown during the request
      throw Exception('Error occurred: $e');
    }
  }
}

