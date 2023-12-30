
class Picklists {
final String id;
final int? metadataFieldID;
final String displayName;
final bool? deleteFlag;


Picklists({
required this.id,
this.metadataFieldID,
required this.displayName,
this.deleteFlag,
});

factory Picklists.fromJson(Map<String, dynamic> json) {
    return Picklists(
id: json['id'] as String,
metadataFieldID: json['metadataFieldID'] as int,
displayName: json['displayName'] as String,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

