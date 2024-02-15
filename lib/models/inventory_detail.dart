// ignore: file_names
// ignore: file_names
class InventoryDetail {
  final int id;
  final String name;
  final String dateCreated;
  final String dateUpdated;
  final String status;
  final String source;
  final String fileName;
  final String createdByDisplay;
  final String collectionDisplay;
  final String categoryDisplay;
  final List<Metadata> metadata;

  InventoryDetail({
    required this.id,
    required this.name,
    required this.dateCreated,
    required this.dateUpdated,
    required this.status,
    required this.source,
    required this.fileName,
    required this.createdByDisplay,
    required this.collectionDisplay,
    required this.categoryDisplay,
    required this.metadata,
  });

  factory InventoryDetail.fromJson(Map<String, dynamic> json) {
    return InventoryDetail(
      id: json['id'] as int,
      name: json['name'] ?? '',
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      status: json['status'] ?? '',
      source: json['source'] ?? '',
      fileName: json['FileName'] ?? '',
      createdByDisplay: json['createdby_display'] ?? '',
      collectionDisplay: json['collection_display'] ?? '',
      categoryDisplay: json['category_display'] ?? '',
      metadata: json['metadata'] != null
          ? (json['metadata'] as List)
              .map((item) => Metadata.fromJson(item))
              .toList()
          : [],
    );
  }
}

class Metadata {
  final String metalabel;
  final String metavalue;
  final int orderno;

  Metadata({
    required this.metalabel,
    required this.metavalue,
    required this.orderno,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      metalabel: json['metalabel'] ?? '',
      metavalue: json['metavalue'] ?? '',
      orderno: json['orderno'] as int,
    );
  }
}
