import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

enum AssetImageStatusEnum {
  unknown,
  available;

  factory AssetImageStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'AVAILABLE':
        return available;
      default:
        return unknown;
    }
  }
}

enum AssetImageTypeEnum {
  unknown,
  hd1080,
  source,
  thumbnail;

  factory AssetImageTypeEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'HD1080':
        return hd1080;
      case 'SOURCE':
        return source;
      case 'THUMBNAIL':
        return thumbnail;
      default:
        return unknown;
    }
  }
}

class AssetImageModel extends Equatable {
  final String id;
  final String assetID;
  final AssetImageStatusEnum status;
  final AssetImageTypeEnum type;
  final String mount;
  final String path;
  final DateTime importedAt;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final Int64 sizeOnDisk;
  final String md5Hash;
  final String mimeType;
  final Int32 width;
  final Int32 height;

  const AssetImageModel({
    required this.id,
    required this.assetID,
    required this.status,
    required this.type,
    required this.mount,
    required this.path,
    required this.importedAt,
    required this.createdAt,
    required this.modifiedAt,
    required this.sizeOnDisk,
    required this.md5Hash,
    required this.mimeType,
    required this.width,
    required this.height,
  });

  static AssetImageModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetImageModel(
      id: dto?['id'] ?? '',
      assetID: dto?['asset_id'] ?? '',
      status: AssetImageStatusEnum.fromJsonDtoValue(dto?['status']),
      type: AssetImageTypeEnum.fromJsonDtoValue(dto?['type']),
      mount: dto?['mount'] ?? '',
      path: dto?['path'] ?? '',
      importedAt: DateTime.parse(
        dto?['imported_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      modifiedAt: DateTime.parse(
        dto?['modified_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      sizeOnDisk: Int64(dto?['size_on_disk'] ?? 0),
      md5Hash: dto?['md5_hash'] ?? '',
      mimeType: dto?['mime_type'] ?? '',
      width: Int32(dto?['width'] ?? 0),
      height: Int32(dto?['height'] ?? 0),
    );
  }

  @override
  List<Object?> get props => [
        id,
        assetID,
        status,
        type,
        mount,
        path,
        importedAt,
        createdAt,
        modifiedAt,
        sizeOnDisk,
        md5Hash,
        mimeType,
        width,
        height,
      ];
}
