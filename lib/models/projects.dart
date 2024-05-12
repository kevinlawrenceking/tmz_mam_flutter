class Projects {
  final int id;
  final String? name;
  final int? userID;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final String? description;
  final bool? deleteFlag;

  Projects({
    required this.id,
    this.name,
    this.userID,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.deleteFlag,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      id: json['id'] as int,
      name: json['name'] as String,
      userID: json['userID'] as int,
      dateCreated: json['dateCreated'] != null
          ? DateTime.parse(json['dateCreated'])
          : null,
      dateUpdated: json['dateUpdated'] != null
          ? DateTime.parse(json['dateUpdated'])
          : null,
      description: json['description'] as String,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
