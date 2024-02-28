import 'package:tmz_mam_flutter/data/models/inventory_metadata.dart';

class InventoryModel {
  final int id;
  final String name;
  final String mediaPath;
  final String thumbnail;
  final String? createdBy;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final List<InventoryMetadataModel> metadata;

  InventoryModel({
    required this.id,
    required this.name,
    required this.mediaPath,
    required this.thumbnail,
    required this.createdBy,
    required this.dateCreated,
    required this.dateUpdated,
    required this.metadata,
  });

  static InventoryModel fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'] as int,
      name: json['name'] ?? '-',
      mediaPath: json['mediaPath'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
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
