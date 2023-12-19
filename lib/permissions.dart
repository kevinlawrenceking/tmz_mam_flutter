
class Permissions {
final int id;
final int? userID;
final String? privilegeId;
final int? roleID;
final bool? deleteFlag;


Permissions({
required this.id,
this.userID,
this.privilegeId,
this.roleID,
this.deleteFlag,
});

factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
id: json['id'] as int,
userID: json['userID'] as int,
privilegeId: json['privilegeId'] as String,
roleID: json['roleID'] as int,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

