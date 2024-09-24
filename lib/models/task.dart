class Task {
  String id;
  String title;
  bool isCompleted;
  DateTime? deletedAt;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'deletedAt': deletedAt
      };

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      deletedAt: json['deletedAt'],
    );
  }
}
