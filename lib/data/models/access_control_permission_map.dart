import 'package:equatable/equatable.dart';

class AccessControlPermissionMapModel extends Equatable {
  final AccessControlPermissionMapAssetsModel assets;
  final AccessControlPermissionMapCollectionsModel collections;

  const AccessControlPermissionMapModel({
    required this.assets,
    required this.collections,
  });

  static AccessControlPermissionMapModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AccessControlPermissionMapModel(
      assets: AccessControlPermissionMapAssetsModel.fromJsonDto(
        dto?['assets'],
      ),
      collections: AccessControlPermissionMapCollectionsModel.fromJsonDto(
        dto?['collections'],
      ),
    );
  }

  @override
  List<Object?> get props => [
        assets,
        collections,
      ];
}

class AccessControlPermissionMapAssetsModel extends Equatable {
  final bool canImport;
  final bool canDelete;
  final bool canDeleteMultiple;
  final bool canModify;
  final bool canBulkUpdate;
  final bool canSearch;
  final bool canViewDetails;
  final bool canDownloadSource;

  const AccessControlPermissionMapAssetsModel({
    required this.canImport,
    required this.canDelete,
    required this.canDeleteMultiple,
    required this.canModify,
    required this.canBulkUpdate,
    required this.canSearch,
    required this.canViewDetails,
    required this.canDownloadSource,
  });

  static AccessControlPermissionMapAssetsModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AccessControlPermissionMapAssetsModel(
      canImport: dto?['can_import'] ?? false,
      canDelete: dto?['can_delete'] ?? false,
      canDeleteMultiple: dto?['can_delete_multiple'] ?? false,
      canModify: dto?['can_modify'] ?? false,
      canBulkUpdate: dto?['can_bulk_update'] ?? false,
      canSearch: dto?['can_search'] ?? false,
      canViewDetails: dto?['can_view_details'] ?? false,
      canDownloadSource: dto?['can_download_source'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        canImport,
        canDelete,
        canDeleteMultiple,
        canModify,
        canBulkUpdate,
        canSearch,
        canViewDetails,
        canDownloadSource,
      ];
}

class AccessControlPermissionMapCollectionsModel extends Equatable {
  final bool canCreate;
  final bool canDelete;
  final bool canDeleteMultiple;
  final bool canModify;
  final bool canAddAssets;
  final bool canRemoveAssets;
  final bool canAssignOwner;
  final bool canViewPrivate;

  const AccessControlPermissionMapCollectionsModel({
    required this.canCreate,
    required this.canDelete,
    required this.canDeleteMultiple,
    required this.canModify,
    required this.canAddAssets,
    required this.canRemoveAssets,
    required this.canAssignOwner,
    required this.canViewPrivate,
  });

  static AccessControlPermissionMapCollectionsModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AccessControlPermissionMapCollectionsModel(
      canCreate: dto?['can_create'] ?? false,
      canDelete: dto?['can_delete'] ?? false,
      canDeleteMultiple: dto?['can_delete_multiple'] ?? false,
      canModify: dto?['can_modify'] ?? false,
      canAddAssets: dto?['can_add_assets'] ?? false,
      canRemoveAssets: dto?['can_remove_assets'] ?? false,
      canAssignOwner: dto?['can_assign_owner'] ?? false,
      canViewPrivate: dto?['can_view_private'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        canCreate,
        canDelete,
        canDeleteMultiple,
        canModify,
        canAddAssets,
        canRemoveAssets,
        canAssignOwner,
        canViewPrivate,
      ];
}
