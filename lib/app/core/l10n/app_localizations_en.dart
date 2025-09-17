// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tasksManager => 'Task Manager';

  @override
  String get loading => 'Loading tasks';

  @override
  String errorList(String error) {
    return 'Error loading tasks\n$error';
  }

  @override
  String get reload => 'Reload';

  @override
  String get total => 'Total';

  @override
  String get pendent => 'Pending';

  @override
  String get completed => 'Completed';

  @override
  String get searchTasks => 'Search tasks...';

  @override
  String allTasksValue(String value) {
    return 'All ($value)';
  }

  @override
  String pendentTasksValue(Object value) {
    return 'Pending ($value)';
  }

  @override
  String completedtTasksValue(String value) {
    return 'Completed ($value)';
  }

  @override
  String get editTask => 'Edit Task';

  @override
  String get newTask => 'New Task';

  @override
  String get title => 'Title *';

  @override
  String get enterTitle => 'Enter title';

  @override
  String get description => 'Description (optional)';

  @override
  String get enterDescription => 'Enter description';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String createdAt(String createdAt) {
    return 'Created on\n$createdAt';
  }

  @override
  String editedAt(String editedAt) {
    return 'Edited on\n$editedAt';
  }

  @override
  String completedAt(String completedAt) {
    return 'Completed on\n$completedAt';
  }

  @override
  String get addFirstTask => 'No tasks found';

  @override
  String get failedToInicialize => 'Failed to start';

  @override
  String get failedToLoad => 'Failed to load tasks';

  @override
  String get failedToUpdate => 'Failed to update task';

  @override
  String get failedToAdd => 'Failed to add task';

  @override
  String get failedToDelete => 'Failed to delete task';

  @override
  String get failedToToggleStatus => 'Failed to change task status';

  @override
  String get failedToSearch => 'Failed to search task';
}
