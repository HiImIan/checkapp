class TaskModel {
  final String id;
  final String title;
  final String subtitle;
  final String createdAt;
  final String editedAt;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.editedAt,
    required this.isCompleted,
  });
}
