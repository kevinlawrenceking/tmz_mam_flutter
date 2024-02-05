// ignore_for_file: file_names

class MetadataGroups {
  final int id;
  final String? name;
  final DateTime? created;
  final DateTime? updated;
  final bool? deleteFlag;

  MetadataGroups({
    required this.id,
    this.name,
    this.created,
    this.updated,
    this.deleteFlag,
  });

  factory MetadataGroups.fromJson(Map<String, dynamic> json) {
    return MetadataGroups(
      id: json['id'] as int,
      name: json['name'] as String,
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
