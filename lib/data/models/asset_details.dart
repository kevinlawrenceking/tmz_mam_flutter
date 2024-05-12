import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/models/user.dart';

enum AssetStatusEnum {
  unknown,
  available,
  deleted,
  processing;

  factory AssetStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'AVAILABLE':
        return available;
      case 'DELETED':
        return deleted;
      case 'PROCESSING':
        return processing;
      default:
        return unknown;
    }
  }
}

class AssetDetailsModel extends Equatable {
  final String id;
  final AssetStatusEnum status;
  final UserMetaModel createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String originalFileName;
  final String headline;
  final List<String> categories;
  final AssetMetadataModel metadata;
  final List<AssetImageModel> images;
  final List<AssetDetailsAppearsInModel> appearsIn;

  const AssetDetailsModel({
    required this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.originalFileName,
    required this.headline,
    required this.categories,
    required this.metadata,
    required this.images,
    required this.appearsIn,
  });

  static AssetDetailsModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetDetailsModel(
      id: dto?['id'] ?? '',
      status: AssetStatusEnum.fromJsonDtoValue(dto?['status']),
      createdBy: UserMetaModel.fromJsonDto(dto?['created_by']),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      updatedAt: DateTime.parse(
        dto?['updated_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      originalFileName: dto?['original_file_name'] ?? '',
      headline: dto?['headline'] ?? '',
      categories: (dto?['categories'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      metadata: AssetMetadataModel.fromJsonDto(dto?['metadata']),
      images: (dto?['images'] as List<dynamic>?)
              ?.map((_) => AssetImageModel.fromJsonDto(_))
              .toList() ??
          [],
      appearsIn: (dto?['appears_in'] as List<dynamic>?)
              ?.map((_) => AssetDetailsAppearsInModel.fromJsonDto(_))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        createdBy,
        createdAt,
        updatedAt,
        originalFileName,
        headline,
        categories,
        metadata,
        images,
        appearsIn,
      ];
}

class AssetDetailsAppearsInModel extends Equatable {
  final String collectionID;
  final String name;

  const AssetDetailsAppearsInModel({
    required this.collectionID,
    required this.name,
  });

  static AssetDetailsAppearsInModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetDetailsAppearsInModel(
      collectionID: dto?['collection_id'] ?? '',
      name: dto?['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        collectionID,
        name,
      ];
}
