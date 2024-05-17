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
  final DateTime updatedAt;
  final bool deleted;
  final UserMetaModel? deletedBy;
  final DateTime? deletedAt;
  final Int32 totalAssets;
  final bool favorited;

  const CollectionModel({
    required this.id,
    required this.ownedBy,
    required this.isPrivate,
    required this.autoClear,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.deletedBy,
    required this.deletedAt,
    required this.totalAssets,
    required this.favorited,
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
        dto?['created_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        dto?['updated_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      deleted: dto?['deleted'] ?? false,
      deletedBy: dto?['deleted_by'] != null
          ? UserMetaModel.fromJsonDto(dto?['deleted_by'])
          : null,
      deletedAt: DateTime.tryParse(dto?['deleted_at'] ?? ''),
      totalAssets: Int32(dto?['total_assets'] ?? 0),
      favorited: dto?['favorited'] ?? false,
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
        updatedAt,
        deleted,
        deletedBy,
        deletedAt,
        totalAssets,
        favorited,
      ];

  CollectionModel copyWith({
    bool? isPrivate,
    bool? autoClear,
    String? name,
    String? description,
    bool? favorited,
  }) {
    return CollectionModel(
      id: id,
      ownedBy: ownedBy.copy(),
      isPrivate: isPrivate ?? this.isPrivate,
      autoClear: autoClear ?? this.autoClear,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt.add(Duration.zero),
      updatedAt: updatedAt.add(Duration.zero),
      deleted: deleted,
      deletedBy: deletedBy?.copy(),
      deletedAt: deletedAt?.add(Duration.zero),
      totalAssets: totalAssets,
      favorited: favorited ?? this.favorited,
    );
  }
}
