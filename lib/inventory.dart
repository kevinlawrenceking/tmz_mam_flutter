class Inventory {
final int id;
final String type;
final DateTime? created;
final DateTime? lastUpdated;
final String name;
final int version;
final int metadataID;
final bool truncatedFlag;
final bool? thumbnailAssetFlag;
final int filesize;
final String fileExtension;
final int width;
final int checksum;
final int height;
final bool versionFlag;
final DateTime? dateLocked;
final bool searchableFlag;
final DateTime? sourceDateCreated;
final int imageContentID;
final bool placeholder;
final String? restoreKey;
final String sourceFilePath;
final String status;
final bool? deleteFlag;
final String thumbnail;
  final List<Map<String, String?>> metadata;

Inventory({
required this.id,
this.assetType,
this.dateCreated,
this.dateUpdated,
this.name,
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
this.thumbnail,
this.systemKeywords,
this.metadata,
});

 factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
id: json['id'] as int,
type: json['type'] as String,
created: json['created'] != null ? DateTime.parse(json['created']) : null,
lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
name: json['name'] as String,
version: json['version'] as int,
metadataID: json['metadataID'] as int,
truncatedFlag: json['truncatedFlag'] as bool,
thumbnailAssetFlag: json['thumbnailAssetFlag'] as bool,
filesize: json['filesize'] as int,
fileExtension: json['fileExtension'] as String,
width: json['width'] as int,
checksum: json['checksum'] as int,
height: json['height'] as int,
versionFlag: json['versionFlag'] as bool,
dateLocked: json['dateLocked'] != null ? DateTime.parse(json['dateLocked']) : null,
searchableFlag: json['searchableFlag'] as bool,
sourceDateCreated: json['sourceDateCreated'] != null ? DateTime.parse(json['sourceDateCreated']) : null,
imageContentID: json['imageContentID'] as int,
placeholder: json['placeholder'] as bool,
restoreKey: json['restoreKey'] as String,
sourceFilePath: json['sourceFilePath'] as String,
status: json['status'] as String,
deleteFlag: json['deleteFlag'] as bool,
thumbnail: json['thumbnail'] as String,
metadata: json['metadata'] != null
        ? (json['metadata'] as List).map((item) => Map<String, String?>.from(item as Map)).toList()
        : <Map<String, String?>>[], // Provide an empty list if metadata is null
    );
  }
}