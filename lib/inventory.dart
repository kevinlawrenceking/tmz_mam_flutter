
class Inventory {
final int id;
final String? assetType;
final DateTime? dateCreated;
final DateTime? dateUpdated;
final String? name;
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
final String? thumbnail;
final String? systemKeywords;


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
});

factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
id: json['id'] as int,
assetType: json['assetType'] as String?,
dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
dateUpdated: json['dateUpdated'] != null ? DateTime.parse(json['dateUpdated']) : null,
name: json['name'] as String?,
createdBy: json['createdBy'] as String?,
dateLocked: json['dateLocked'] as String?,
metadataID: json['metadataID'] as int?,
placeholder: json['placeholder'] as bool?,
inventoryKey: json['inventoryKey'] as String?,
inventoryTypeName: json['inventoryTypeName'] as String?,
restoreKey: json['restoreKey'] as String?,
searchableFlag: json['searchableFlag'] as bool?,
sourceDateCreated: json['sourceDateCreated'] != null ? DateTime.parse(json['sourceDateCreated']) : null,
sourceFilePath: json['sourceFilePath'] as String?,
status: json['status'] as String?,
checksum: json['checksum'] as String?,
fileExtension: json['fileExtension'] as String?,
filesize: json['filesize'] as int?,
height: json['height'] as int?,
width: json['width'] as int?,
thumbnailAssetFlag: json['thumbnailAssetFlag'] as bool?,
thumbnailid: json['thumbnailid'] as int?,
truncatedFlag: json['truncatedFlag'] as bool?,
uuid: json['uuid'] as String?,
versionFlag: json['versionFlag'] as bool?,
imageContentID: json['imageContentID'] as int?,
thumbnail: json['thumbnail'] as String?,
systemKeywords: json['systemKeywords'] as String?,

    );
  }
}

