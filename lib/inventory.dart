class Inventory {
final int id;
final String? assetType;
final DateTime? dateCreated;
final DateTime? dateUpdated;
final String name;
final String? createdBy;
final String? dateLocked;
final int? metadataID;
final bool? placeholder;
final String? inventoryKey;
final String? inventoryTypeName;
final String? restoreKey;
final bool? searchableFlag;
final DateTime? sourceDateCreated;
final String? sourceFilePath;
final String? status;
final String? checksum;
final String? fileExtension;
final int? filesize;
final int? height;
final int? width;
final bool? thumbnailAssetFlag;
final int? thumbnailid;
final bool? truncatedFlag;
final String? uuid;
final bool? versionFlag;
final int? imageContentID;
final String thumbnail;
final String? systemKeywords;
final List<Map<String, String?>> metadata;

  Inventory({
 required this.id,
this.assetType = "-",
this.dateCreated,
this.dateUpdated,
this.name  = "-",
this.createdBy,
this.dateLocked,
this.metadataID,
this.placeholder,
this.inventoryKey,
this.inventoryTypeName,
this.restoreKey,
this.searchableFlag,
this.sourceDateCreated,
this.sourceFilePath,
this.status,
this.checksum,
this.fileExtension,
this.filesize,
this.height,
this.width,
this.thumbnailAssetFlag,
this.thumbnailid,
this.truncatedFlag,
this.uuid,
this.versionFlag,
this.imageContentID,
this.thumbnail = "Unknown",
this.systemKeywords,
    required this.metadata,
  });

 factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'] as int,
      name: json['name'] ?? '', // Provide a default value
      metadataID: json['metadataID'] ?? 0, // Provide a default value
      truncatedFlag: json['truncatedFlag'] ?? false, // Provide a default value
      thumbnailAssetFlag: json['thumbnailAssetFlag'] ?? false, // Provide a default value
      filesize: json['filesize'] ?? 0, // Provide a default value
      fileExtension: json['fileExtension'] ?? '', // Provide a default value
      width: json['width'] ?? 0, // Provide a default value
      checksum: json['checksum'] ?? '', // Provide a default value
      height: json['height'] ?? 0, // Provide a default value
      versionFlag: json['versionFlag'] ?? false, // Provide a default value
      dateLocked: json['dateLocked'], // Nullable
      searchableFlag: json['searchableFlag'] ?? false, // Provide a default value
      sourceDateCreated: json['sourceDateCreated'] != null ? DateTime.parse(json['sourceDateCreated']) : null,
      imageContentID: json['imageContentID'] ?? 0, // Provide a default value
      placeholder: json['placeholder'] ?? false, // Provide a default value
      restoreKey: json['restoreKey'], // Nullable
      sourceFilePath: json['sourceFilePath'] ?? '', // Provide a default value
      status: json['status'] ?? '', // Provide a default value
      thumbnail: json['thumbnail'] ?? '', // Provide a default value
      metadata: json['metadata'] != null
        ? (json['metadata'] as List).map((item) => Map<String, String?>.from(item as Map)).toList()
        : <Map<String, String?>>[], // Provide an empty list if metadata is null
    );
  }
}
