import 'package:checkapp/app/data/repositories/tasks_repository.dart';
import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<TaskModel> get tasks => _tasks;
  final List<TaskModel> _tasks = [];

  TasksViewModel({required tasksRepository})
    : _tasksRepository = tasksRepository;
}
