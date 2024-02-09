import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmz_mam_flutter/models/inventory.dart'; // Ensure this path is correct

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fetch inventory data from the API with pagination and optional search term
  Future<InventoryResponse> fetchInventory(int limit, int offset,
      {String? searchTerm}) async {
    // Construct the URL with optional searchTerm
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    if (searchTerm != null && searchTerm.isNotEmpty) {
      queryParams['searchTerm'] = searchTerm;
    }

    final url = Uri.parse('$baseUrl/inventory/light')
        .replace(queryParameters: queryParams);

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'apiKey':
            'ec2d2742-834f-11ee-b962-0242ac120002', // Consider securing your API key
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Print the total records for debugging
        print('Total Records from API: ${data['totalRecords']}');

        return InventoryResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to load inventory. Status code: ${response.statusCode}. Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching inventory: $e');
      throw Exception('Error occurred while fetching inventory: $e');
    }
  }
}
