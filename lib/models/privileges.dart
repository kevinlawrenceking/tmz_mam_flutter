class Privileges {
  final String id;
  final String displayName;
  final bool? deleteFlag;

  Privileges({
    required this.id,
    required this.displayName,
    this.deleteFlag,
  });

  factory Privileges.fromJson(Map<String, dynamic> json) {
    return Privileges(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
