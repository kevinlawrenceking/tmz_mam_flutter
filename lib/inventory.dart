class Inventory {
  final String name;
  final int metadataID;
  final bool truncatedFlag;
  final bool thumbnailAssetFlag;
  final int filesize;
  final String fileExtension;
  final int width;
  final String checksum;
  final int height;
  final bool versionFlag;
  final String? dateLocked;
  final bool searchableFlag;
  final DateTime? sourceDateCreated;
  final int imageContentID;
  final bool placeholder;
  final String? restoreKey;
  final String sourceFilePath;
  final String status;
  final String thumbnail;
  final List<Map<String, String?>> metadata;

  Inventory({
    required this.name,
    required this.metadataID,
    required this.truncatedFlag,
    required this.thumbnailAssetFlag,
    required this.filesize,
    required this.fileExtension,
    required this.width,
    required this.checksum,
    required this.height,
    required this.versionFlag,
    this.dateLocked,
    required this.searchableFlag,
    this.sourceDateCreated,
    required this.imageContentID,
    required this.placeholder,
    this.restoreKey,
    required this.sourceFilePath,
    required this.status,
    required this.thumbnail,
    required this.metadata,
  });

 factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
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
