import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';

enum AssetImportSessionStatusEnum {
  unknown,
  complete,
  error,
  finalized,
  $new,
  processing;

  factory AssetImportSessionStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'COMPLETE':
        return complete;
      case 'ERROR':
        return error;
      case 'FINALIZED':
        return finalized;
      case 'NEW':
        return $new;
      case 'PROCESSING':
        return processing;
      default:
        return unknown;
    }
  }
}

class AssetImportSessionModel extends Equatable {
  final String id;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AssetImportSessionStatusEnum status;

  const AssetImportSessionModel({
    required this.id,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  static AssetImportSessionModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionModel(
      id: dto?['id'] ?? '',
      userID: dto?['user_id'] ?? '',
      createdAt: DateTime.parse(
        dto?['created_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        dto?['updated_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      status: AssetImportSessionStatusEnum.fromJsonDtoValue(dto?['status']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userID,
        createdAt,
        updatedAt,
        status,
      ];
}

class AssetImportSessionDetailsModel extends Equatable {
  final String id;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AssetImportSessionStatusEnum status;
  final List<AssetImportSessionFileModel> files;

  const AssetImportSessionDetailsModel({
    required this.id,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.files,
  });

  static AssetImportSessionDetailsModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionDetailsModel(
      id: dto?['id'] ?? '',
      userID: dto?['user_id'] ?? '',
      createdAt: DateTime.parse(
        dto?['created_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        dto?['updated_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      status: AssetImportSessionStatusEnum.fromJsonDtoValue(dto?['status']),
      files: (dto?['files'] as List<dynamic>?)
              ?.map((_) => AssetImportSessionFileModel.fromJsonDto(_))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        userID,
        createdAt,
        updatedAt,
        status,
        files,
      ];
}
