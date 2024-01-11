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
  final List<Map<String, dynamic>> metadata;

  Inventory({
    required this.id,
    this.assetType,
    this.dateCreated,
    this.dateUpdated,
    required this.name,
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
    required this.thumbnail,
    this.systemKeywords,
    required this.metadata,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> parsedMetadata = [];
    if (json['metadata'] != null) {
      parsedMetadata = (json['metadata'] as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    
      // Debug: Print the metadata before sorting
      print("Metadata before sorting: $parsedMetadata");

      // Sort the metadata by 'orderno'
      parsedMetadata.sort((a, b) {
        int orderA = int.tryParse(a['orderno']?.toString() ?? '0') ?? 0;
        int orderB = int.tryParse(b['orderno']?.toString() ?? '0') ?? 0;
        return orderA.compareTo(orderB);
      });

      // Debug: Print the metadata after sorting
      print("Metadata after sorting: $parsedMetadata");
    }

    return Inventory(
      id: json['id'] as int? ?? 0,
      assetType: json['assetType'],
      dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
      dateUpdated: json['dateUpdated'] != null ? DateTime.parse(json['dateUpdated']) : null,
      name: json['name'] ?? '',
      createdBy: json['createdBy'],
      dateLocked: json['dateLocked'],
      metadataID: json['metadataID'] as int?,
      placeholder: json['placeholder'],
      inventoryKey: json['inventoryKey'],
      inventoryTypeName: json['inventoryTypeName'],
      restoreKey: json['restoreKey'],
      searchableFlag: json['searchableFlag'],
      sourceDateCreated: json['sourceDateCreated'] != null ? DateTime.parse(json['sourceDateCreated']) : null,
      sourceFilePath: json['sourceFilePath'],
      status: json['status'],
      checksum: json['checksum'],
      fileExtension: json['fileExtension'],
      filesize: json['filesize'] as int?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      thumbnailAssetFlag: json['thumbnailAssetFlag'],
      thumbnailid: json['thumbnailid'] as int?,
      truncatedFlag: json['truncatedFlag'],
      uuid: json['uuid'],
      versionFlag: json['versionFlag'],
      imageContentID: json['imageContentID'] as int?,
      thumbnail: json['thumbnail'] ?? '',
      systemKeywords: json['systemKeywords'],
      metadata: parsedMetadata,
    );
  }
}
