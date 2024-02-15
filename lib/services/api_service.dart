import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmz_mam_flutter/models/inventory.dart'; // Ensure this path is correct
import 'package:tmz_mam_flutter/models/inventory_detail.dart'; // Ensure this path is correct

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fetch inventory data from the API with pagination and optional search term
  Future<InventoryResponse> fetchInventory(int limit, int offset,
      {String? searchTerm}) async {
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
        return InventoryResponse.fromJson(data);
      } else {
        throw Exception('Failed to load inventory: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load inventory: $e');
    }
  }

  // Fetch inventoryDetail by ID
  Future<InventoryDetail> fetchinventoryDetailById(int id) async {
    final url = Uri.parse('$baseUrl/inventory/$id'); // Updated endpoint

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'apiKey':
            'ec2d2742-834f-11ee-b962-0242ac120002', // Consider securing your API key
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InventoryDetail.fromJson(data);
      } else {
        throw Exception(
            'Failed to load inventory details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load inventory details: $e');
    }
  }
}
