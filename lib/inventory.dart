class Inventory {
  final int id;
  final String name;
  final String thumbnail;
  final List<Map<String, String?>> metadata;

  Inventory({required this.id, this.name = "-", this.thumbnail = "Unknown", required this.metadata});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'] as int,
      name: json['name'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      metadata: json['metadata'] != null
          ? (json['metadata'] as List).map((item) => Map<String, String?>.from(item)).toList()
          : [],
    );
  }
}

class InventoryResponse {
  final List<Inventory> inventoryList;
  final int totalRecords;

  InventoryResponse({required this.inventoryList, required this.totalRecords});

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      inventoryList: (json['inventoryList'] as List)
          .map((item) => Inventory.fromJson(item))
          .toList(),
      totalRecords: json['totalRecords'] as int,
    );
  }
}