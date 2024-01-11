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
  List<Map<String, String?>> metadata;

  Inventory({
    required this.id,
    this.assetType = "-",
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
    var inventory = Inventory(
      id: json['id'] as int? ?? 0,
      name: json['name'] ?? '',
      metadataID: json['metadataID'] as int? ?? 0,
      truncatedFlag: json['truncatedFlag'] ?? false,
      thumbnailAssetFlag: json['thumbnailAssetFlag'] ?? false,
      filesize: json['filesize'] ?? 0,
      fileExtension: json['fileExtension'] ?? '',
      width: json['width'] ?? 0,
      checksum: json['checksum'] ?? '',
      height: json['height'] ?? 0,
      versionFlag: json['versionFlag'] ?? false,
      dateLocked: json['dateLocked'],
      searchableFlag: json['searchableFlag'] ?? false,
      sourceDateCreated: json['sourceDateCreated'] != null ? DateTime.parse(json['sourceDateCreated']) : null,
      imageContentID: json['imageContentID'] ?? 0,
      placeholder: json['placeholder'] ?? false,
      restoreKey: json['restoreKey'],
      sourceFilePath: json['sourceFilePath'] ?? '',
      status: json['status'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      metadata: json['metadata'] != null
        ? (json['metadata'] as List).map((item) => Map<String, String?>.from(item as Map)).toList()
        : <Map<String, String?>>[],
    );

    // Sort metadata here
    inventory.sortMetadata();

    return inventory;
  }

  // Method to sort metadata
  void sortMetadata() {
    metadata.sort((a, b) => int.parse(a['orderno'] ?? '0').compareTo(int.parse(b['orderno'] ?? '0')));
  }
}
