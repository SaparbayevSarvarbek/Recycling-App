class CategoryItem {
  final int? id;
  final int groupId;
  final String imagePath;
  final String title;
  final String description;

  CategoryItem({
    this.id,
    required this.groupId,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'imagePath': imagePath,
      'title': title,
      'description': description,
    };
  }

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
      id: map['id'],
      groupId: map['groupId'],
      imagePath: map['imagePath'],
      title: map['title'],
      description: map['description'],
    );
  }
}
