// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String createdAt;

  @HiveField(4)
  final String? editedAt;

  @HiveField(5)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.editedAt,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    String? createdAt,
    String? editedAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
