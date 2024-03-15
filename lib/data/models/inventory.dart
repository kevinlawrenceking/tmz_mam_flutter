import 'package:tmz_damz/data/models/inventory_metadata.dart';

class InventoryModel {
  final int id;
  final String name;
  final String mediaPath;
  final String downloadUrl;
  final String thumbnailUrl;
  final String? createdBy;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final List<InventoryMetadataModel> metadata;

  InventoryModel({
    required this.id,
    required this.name,
    required this.mediaPath,
    required this.downloadUrl,
    required this.thumbnailUrl,
    required this.createdBy,
    required this.dateCreated,
    required this.dateUpdated,
    required this.metadata,
  });

  static InventoryModel fromJson({
    required String apiBaseUrl,
    required Map<String, dynamic> json,
  }) {
    final id = json['id'] as int;

    return InventoryModel(
      id: id,
      name: json['name'] ?? '-',
      mediaPath: json['mediaPath'] ?? '',
      downloadUrl: '$apiBaseUrl/inventory/$id/download',
      thumbnailUrl: '$apiBaseUrl/inventory/$id/thumbnail',
      createdBy: json['createdBy'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateUpdated: DateTime.parse(json['dateUpdated']),
      metadata: json['metadata'] != null
          ? (json['metadata'] as List)
              .map((item) => InventoryMetadataModel.fromJson(item))
              .toList()
          : [],
    );
  }
}
