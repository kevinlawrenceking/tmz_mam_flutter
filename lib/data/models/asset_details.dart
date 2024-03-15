import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';

enum AssetStatusEnum {
  unknown,
  available,
  processing;

  factory AssetStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'AVAILABLE':
        return available;
      case 'PROCESSING':
        return processing;
      default:
        return unknown;
    }
  }
}

class AssetDetailsModel {
  final String id;
  final AssetStatusEnum status;
  final AssetCreatedByModel createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String originalFileName;
  final String headline;
  final AssetMetadataModel metadata;
  final List<AssetImageModel> images;

  AssetDetailsModel({
    required this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.originalFileName,
    required this.headline,
    required this.metadata,
    required this.images,
  });

  static AssetDetailsModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetDetailsModel(
      id: dto?['id'] ?? '',
      status: AssetStatusEnum.fromJsonDtoValue(dto?['status']),
      createdBy: AssetCreatedByModel.fromJsonDto(dto?['created_by']),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      updatedAt: DateTime.parse(
        dto?['updated_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      originalFileName: dto?['original_file_name'] ?? '',
      headline: dto?['headline'] ?? '',
      metadata: AssetMetadataModel.fromJsonDto(dto?['metadata']),
      images: (dto?['images'] as List<dynamic>?)
              ?.map((_) => AssetImageModel.fromJsonDto(_))
              .toList() ??
          [],
    );
  }
}

class AssetCreatedByModel {
  final String userID;
  final String firstName;
  final String lastName;

  AssetCreatedByModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
  });

  static AssetCreatedByModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetCreatedByModel(
      userID: dto?['user_id'] ?? '',
      firstName: dto?['first_name'] ?? '',
      lastName: dto?['last_name'] ?? '',
    );
  }
}
