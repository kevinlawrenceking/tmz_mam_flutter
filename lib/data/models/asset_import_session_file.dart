import 'package:fixnum/fixnum.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';

enum AssetImportSessionFileStatusEnum {
  unknown,
  error,
  imported,
  $new,
  processing,
  ready;

  factory AssetImportSessionFileStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'ERROR':
        return error;
      case 'IMPORTED':
        return imported;
      case 'NEW':
        return $new;
      case 'PROCESSING':
        return processing;
      case 'READY':
        return ready;
      default:
        return unknown;
    }
  }
}

enum AssetImportSessionFileThumbnailStatusEnum {
  unknown,
  error,
  imported,
  processing,
  ready;

  factory AssetImportSessionFileThumbnailStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'ERROR':
        return error;
      case 'IMPORTED':
        return imported;
      case 'PROCESSING':
        return processing;
      case 'READY':
        return ready;
      default:
        return unknown;
    }
  }
}

class AssetImportSessionFileModel {
  final String id;
  final String sessionID;
  final DateTime uploadedAt;
  final AssetImportSessionFileStatusEnum status;
  final String originalFileName;
  final String sourcePath;
  final String thumbnailPath;
  final AssetImportSessionFileThumbnailStatusEnum thumbnailStatus;
  final AssetImportSessionFileInfoModel fileInfo;
  final AssetImportSessionImageInfoModel imageInfo;
  final AssetImportSessionFileMetaModel meta;

  AssetImportSessionFileModel({
    required this.id,
    required this.sessionID,
    required this.uploadedAt,
    required this.status,
    required this.originalFileName,
    required this.sourcePath,
    required this.thumbnailPath,
    required this.thumbnailStatus,
    required this.fileInfo,
    required this.imageInfo,
    required this.meta,
  });

  static AssetImportSessionFileModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionFileModel(
      id: dto?['id'] ?? '',
      sessionID: dto?['session_id'] ?? '',
      uploadedAt: DateTime.parse(
        dto?['uploaded_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      status: AssetImportSessionFileStatusEnum.fromJsonDtoValue(dto?['status']),
      originalFileName: dto?['original_file_name'] ?? '',
      sourcePath: dto?['source_path'] ?? '',
      thumbnailPath: dto?['thumbnail_path'] ?? '',
      thumbnailStatus:
          AssetImportSessionFileThumbnailStatusEnum.fromJsonDtoValue(
        dto?['thumbnail_status'],
      ),
      fileInfo: AssetImportSessionFileInfoModel.fromJsonDto(dto?['file_info']),
      imageInfo:
          AssetImportSessionImageInfoModel.fromJsonDto(dto?['image_info']),
      meta: AssetImportSessionFileMetaModel.fromJsonDto(dto?['meta']),
    );
  }
}

class AssetImportSessionFileInfoModel {
  final String md5Hash;
  final String mimeType;
  final Int64 sizeOnDisk;
  final DateTime createdAt;
  final DateTime modifiedAt;

  AssetImportSessionFileInfoModel({
    required this.md5Hash,
    required this.mimeType,
    required this.sizeOnDisk,
    required this.createdAt,
    required this.modifiedAt,
  });

  static AssetImportSessionFileInfoModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionFileInfoModel(
      md5Hash: dto?['md5_hash'] ?? '',
      mimeType: dto?['mime_type'] ?? '',
      sizeOnDisk: Int64(dto?['size_on_disk'] ?? 0),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      modifiedAt: DateTime.parse(
        dto?['modified_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
    );
  }
}

class AssetImportSessionImageInfoModel {
  final Int32 height;
  final Int32 width;

  AssetImportSessionImageInfoModel({
    required this.height,
    required this.width,
  });

  static AssetImportSessionImageInfoModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionImageInfoModel(
      height: Int32(dto?['height'] ?? 0),
      width: Int32(dto?['width'] ?? 0),
    );
  }
}

class AssetImportSessionFileMetaModel {
  final String headline;
  final AssetMetadataModel metadata;

  AssetImportSessionFileMetaModel({
    required this.headline,
    required this.metadata,
  });

  static AssetImportSessionFileMetaModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImportSessionFileMetaModel(
      headline: dto?['headline'] ?? '',
      metadata: AssetMetadataModel.fromJsonDto(dto?['metadata']),
    );
  }
}
