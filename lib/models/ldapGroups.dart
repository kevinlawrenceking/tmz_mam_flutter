// ignore_for_file: file_names

class LdapGroups {
  final int id;
  final String? name;
  final String? distinguishedName;
  final bool? deleteFlag;

  LdapGroups({
    required this.id,
    this.name,
    this.distinguishedName,
    this.deleteFlag,
  });

  factory LdapGroups.fromJson(Map<String, dynamic> json) {
    return LdapGroups(
      id: json['id'] as int,
      name: json['name'] as String,
      distinguishedName: json['distinguishedName'] as String,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
