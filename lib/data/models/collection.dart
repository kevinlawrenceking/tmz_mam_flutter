import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';
import 'package:tmz_damz/data/models/user.dart';

class CollectionModel extends Equatable {
  final String id;
  final UserMetaModel ownedBy;
  final bool isPrivate;
  final bool autoClear;
  final String name;
  final String description;
  final DateTime createdAt;
  final bool deleted;
  final UserMetaModel? deletedBy;
  final DateTime? deletedAt;
  final Int32 totalAssets;

  const CollectionModel({
    required this.id,
    required this.ownedBy,
    required this.isPrivate,
    required this.autoClear,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.deleted,
    required this.deletedBy,
    required this.deletedAt,
    required this.totalAssets,
  });

  static CollectionModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return CollectionModel(
      id: dto?['id'] ?? '',
      ownedBy: UserMetaModel.fromJsonDto(dto?['owned_by']),
      isPrivate: dto?['private'] ?? false,
      autoClear: dto?['auto_clear'] ?? false,
      name: dto?['name'] ?? '',
      description: dto?['description'] ?? '',
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      deleted: dto?['deleted'] ?? false,
      deletedBy: dto?['deleted_by'] != null
          ? UserMetaModel.fromJsonDto(dto?['deleted_by'])
          : null,
      deletedAt: DateTime.tryParse(dto?['deleted_at'] ?? ''),
      totalAssets: Int32(dto?['total_assets'] ?? 0),
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownedBy,
        isPrivate,
        autoClear,
        name,
        description,
        createdAt,
        deleted,
        deletedBy,
        deletedAt,
        totalAssets,
      ];
}
