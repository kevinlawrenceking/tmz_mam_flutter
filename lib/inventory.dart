class Inventory {
final int id;
final String name;
final String thumbnail;
final List<Map<String, String?>> metadata;

Inventory({
required this.id,
this.name  = "-",
this.thumbnail = "Unknown",
required this.metadata,
  });

 factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'] as int,
      name: json['name'] ?? '', // Provide a default value
     thumbnail: json['thumbnail'] ?? '', // Provide a default value
      metadata: json['metadata'] != null
        ? (json['metadata'] as List).map((item) => Map<String, String?>.from(item as Map)).toList()
        : <Map<String, String?>>[], // Provide an empty list if metadata is null
    );
  }
}
