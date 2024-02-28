import 'package:tmz_mam_flutter/data/models/inventory_metadata.dart';

class InventoryDetailsModel {
  final int id;
  final String name;
  final String status;
  final String mediaPath;
  final String thumbnail;
  final String? createdBy;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String collections;
  final String categories;
  final List<InventoryMetadataModel> metadata;

  InventoryDetailsModel({
    required this.id,
    required this.name,
    required this.status,
    required this.mediaPath,
    required this.thumbnail,
    required this.createdBy,
    required this.dateCreated,
    required this.dateUpdated,
    required this.collections,
    required this.categories,
    required this.metadata,
  });

  static InventoryDetailsModel fromJson(Map<String, dynamic> json) {
    return InventoryDetailsModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      mediaPath: json['mediaPath'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      createdBy: json['createdBy'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateUpdated: DateTime.parse(json['dateUpdated']),
      collections: json['collections'] ?? '',
      categories: json['categories'] ?? '',
      metadata: json['metadata'] != null
          ? (json['metadata'] as List)
              .map((item) => InventoryMetadataModel.fromJson(item))
              .toList()
          : [],
    );
  }
}
