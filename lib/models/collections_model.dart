class Collections {
  final int id;
  final String? name;
  final int? userID;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final bool? private;
  final String? systemKeywords;
  final String? description;
  final int? projectID;
  final int? imageContentID;
  final bool? contentsArchivedFlag;
  final String? repositoryPath;
  final bool? deleteFlag;

  Collections({
    required this.id,
    this.name,
    this.userID,
    this.dateCreated,
    this.dateUpdated,
    this.private,
    this.systemKeywords,
    this.description,
    this.projectID,
    this.imageContentID,
    this.contentsArchivedFlag,
    this.repositoryPath,
    this.deleteFlag,
  });

  factory Collections.fromJson(Map<String, dynamic> json) {
    return Collections(
      id: json['id'] as int,
      name: json['name'] as String,
      userID: json['userID'] as int,
      dateCreated: json['dateCreated'] != null
          ? DateTime.parse(json['dateCreated'])
          : null,
      dateUpdated: json['dateUpdated'] != null
          ? DateTime.parse(json['dateUpdated'])
          : null,
      private: json['private'] as bool,
      systemKeywords: json['systemKeywords'] as String,
      description: json['description'] as String,
      projectID: json['projectID'] as int,
      imageContentID: json['imageContentID'] as int,
      contentsArchivedFlag: json['contentsArchivedFlag'] as bool,
      repositoryPath: json['repositoryPath'] as String,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
