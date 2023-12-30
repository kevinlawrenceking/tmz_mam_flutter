
class Users {
final int id;
final String? username;
final String? emailAddress;
final String? firstName;
final String? lastName;
final bool? enabled;
final bool? externalUser;
final bool? activated;
final bool? systemUser;
final bool? archivedFlag;
final bool? adminFlag;
final bool? deleteFlag;


Users({
required this.id,
this.username,
this.emailAddress,
this.firstName,
this.lastName,
this.enabled,
this.externalUser,
this.activated,
this.systemUser,
this.archivedFlag,
this.adminFlag,
this.deleteFlag,
});

factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
id: json['id'] as int,
username: json['username'] as String,
emailAddress: json['emailAddress'] as String,
firstName: json['firstName'] as String,
lastName: json['lastName'] as String,
enabled: json['enabled'] as bool,
externalUser: json['externalUser'] as bool,
activated: json['activated'] as bool,
systemUser: json['systemUser'] as bool,
archivedFlag: json['archivedFlag'] as bool,
adminFlag: json['adminFlag'] as bool,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

