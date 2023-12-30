
class AccessGroups {
final int id;
final String name;
final String description;
final bool? deleteFlag;


AccessGroups({
required this.id,
required this.name,
required this.description,
this.deleteFlag,
});

factory AccessGroups.fromJson(Map<String, dynamic> json) {
    return AccessGroups(
id: json['id'] as int,
name: json['name'] as String,
description: json['description'] as String,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

