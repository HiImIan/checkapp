import 'package:checkapp/app/data/repositories/tasks_repository.dart';
import 'package:flutter/material.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;

  TasksViewModel({required tasksRepository})
    : _tasksRepository = tasksRepository;
}
