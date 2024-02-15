class Inventory {
  final int id;
  final String name;
  final String thumbnail;
  final String createdBy;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String headline;
  final List<Map<String, String?>> metadata;

  Inventory({
    required this.id,
    this.name = "-",
    this.thumbnail = "Unknown",
    this.createdBy = "Unknown",
    required this.dateCreated,
    required this.dateUpdated,
    this.headline = "Unknown",
    required this.metadata,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
        id: json['id'] as int,
        name: json['name'] ?? '-',
        thumbnail: json['thumbnail'] ?? 'Unknown',
        createdBy: json['createdBy'] ?? 'Unknown',
        dateCreated: DateTime.parse(json['dateCreated']),
        dateUpdated: DateTime.parse(json['dateUpdated']),
        headline: json['headline'] ?? 'Unknown',
        metadata: json['metadata'] != null
            ? (json['metadata'] as List)
                .map((item) => Map<String, String?>.from(item))
                .toList()
            : []);
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
