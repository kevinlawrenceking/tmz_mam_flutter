
class Images {
final int id;
final int? inventoryID;
final int? width;
final int? height;
final String? name;
final DateTime? created;
final DateTime? lastUpdated;
final String? path;
final int? fileSizeKb;
final String? mimeType;
final bool? archiveStatusTruncated;
final bool? deleteFlag;


Images({
required this.id,
this.inventoryID,
this.width,
this.height,
this.name,
this.created,
this.lastUpdated,
this.path,
this.fileSizeKb,
this.mimeType,
this.archiveStatusTruncated,
this.deleteFlag,
});

factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
id: json['id'] as int,
inventoryID: json['inventoryID'] as int,
width: json['width'] as int,
height: json['height'] as int,
name: json['name'] as String,
created: json['created'] != null ? DateTime.parse(json['created']) : null,
lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
path: json['path'] as String,
fileSizeKb: json['fileSizeKb'] as int,
mimeType: json['mimeType'] as String,
archiveStatusTruncated: json['archiveStatusTruncated'] as bool,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

