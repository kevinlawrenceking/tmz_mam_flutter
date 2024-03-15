class Categories {
  final int id;
  final String? name;
  final String? description;
  final bool? deleteFlag;

  Categories({
    required this.id,
    this.name,
    this.description,
    this.deleteFlag,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      deleteFlag: json['deleteFlag'] as bool,
    );
  }
}
