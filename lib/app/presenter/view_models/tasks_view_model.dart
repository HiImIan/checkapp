import 'package:checkapp/app/data/repositories/tasks_repository.dart';
import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

/// ViewModel that manages tasks state and business logic
class TasksViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  // private variables
  List<TaskModel> _tasks = [];
  int _selectedTab = 0;
  bool _isEditing = false;
  String? _editingTaskId;
  bool _isLoading = false;
  String? _error;

  TasksViewModel({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository,
      titleController = TextEditingController(),
      descriptionController = TextEditingController();

  /// Returns all tasks
  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  // getters
  int get selectedTab => _selectedTab;
  bool get isEditing => _isEditing;
  String? get editingTaskId => _editingTaskId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Returns tasks filtered by current selected tab
  /// Tab 0: All tasks, Tab 1: Pending tasks, Tab 2: Completed tasks
  List<TaskModel> get filteredTasks {
    switch (_selectedTab) {
      case 1:
        return _tasks.where((task) => !task.isCompleted).toList();
      case 2:
        return _tasks.where((task) => task.isCompleted).toList();
      default:
        return _tasks.toList();
    }
  }

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;

  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _tasksRepository.initialize();
      await loadTasks();
    } catch (e) {
      _setError('Error initializing: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Loads all tasks from repository and updates UI
  Future<void> loadTasks() async {
    _setLoading(true);
    _clearError();

    try {
      _tasks = await _tasksRepository.getAllTasks();
      _sortTasksByDate();
      notifyListeners();
    } catch (e) {
      _setError('Error loading tasks: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  //======================================
  //---------------- CRUD ----------------
  //======================================

  /// Creates a new task with current form data
  Future<void> addTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    _clearError();

    try {
      final task = _createNewTask(title, description);
      await _tasksRepository.addTask(task);
      await loadTasks();
    } catch (e) {
      _setError('Error adding task: ${e.toString()}');
    }
  }

  /// Updates an existing task with current form data
  Future<void> updateTask() async {
    if (_editingTaskId == null) return;

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    _clearError();

    try {
      final updatedTask = _createUpdatedTask(title, description);
      await _tasksRepository.updateTask(updatedTask);
      await loadTasks();
    } catch (e) {
      _setError('Error updating task: ${e.toString()}');
    }
  }

  /// Saves task (add or update based on current editing state)
  Future<void> saveTask() async {
    if (_isEditing) {
      await updateTask();
    } else {
      await addTask();
    }
  }

  /// Deletes a task by ID
  Future<void> deleteTask(String taskId) async {
    _clearError();

    try {
      await _tasksRepository.deleteTask(taskId);
      await loadTasks();
    } catch (e) {
      _setError('Error deleting task: ${e.toString()}');
    }
  }

  /// Toggles the completion status of a task
  Future<void> toggleTaskCompletion(String taskId) async {
    _clearError();

    try {
      await _tasksRepository.toggleTaskCompletion(taskId);
      await loadTasks();
    } catch (e) {
      _setError('Error toggling task completion: ${e.toString()}');
    }
  }

  /// Searches tasks by query string
  /// If query is empty, loads all tasks
  Future<void> searchTasks(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      await loadTasks();
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      _tasks = await _tasksRepository.searchTasks(trimmedQuery);
      notifyListeners();
    } catch (e) {
      _setError('Error searching tasks: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Dialog state management methods

  /// Prepares ViewModel state for adding a new task
  void prepareAddTask() {
    _isEditing = false;
    _editingTaskId = null;
    titleController.clear();
    descriptionController.clear();
    _clearError();
  }

  /// Prepares ViewModel state for editing an existing task
  void prepareEditTask(TaskModel task) {
    _isEditing = true;
    _editingTaskId = task.id;
    titleController.text = task.title;
    descriptionController.text = task.description;
    _clearError();
  }

  // UI state management

  /// Sets the selected tab and updates filtered tasks
  void setSelectedTab(int tab) {
    if (_selectedTab != tab) {
      _selectedTab = tab;
      notifyListeners();
    }
  }

  /// Creates a new TaskModel instance with current timestamp
  TaskModel _createNewTask(String title, String description) {
    final dateStr = _getCurrentDateString();
    return TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: dateStr,
      editedAt: null,
      isCompleted: false,
    );
  }

  /// Creates an updated TaskModel instance preserving original creation date
  TaskModel _createUpdatedTask(String title, String description) {
    final existingTask = _tasks.firstWhere((task) => task.id == _editingTaskId);

    return TaskModel(
      id: existingTask.id,
      title: title,
      description: description,
      createdAt: existingTask.createdAt,
      editedAt: _getCurrentDateString(),
      isCompleted: existingTask.isCompleted,
    );
  }

  /// Returns current date formatted as DD/MM/YYYY
  String _getCurrentDateString() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }

  /// Sorts tasks by edited date (newest first)
  void _sortTasksByDate() {
    _tasks.sort((a, b) {
      final aDate = _parseDate(a.editedAt ?? a.createdAt);
      final bDate = _parseDate(b.editedAt ?? a.createdAt);
      return bDate.compareTo(aDate);
    });
  }

  /// Parses date string in DD/MM/YYYY format to DateTime
  DateTime _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length != 3) return DateTime.now();

      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Sets loading state and notifies listeners
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Sets error message and notifies listeners
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  /// Clears current error message and notifies listeners if there was an error
  void _clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Disposes resources when ViewModel is no longer needed
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _tasksRepository.dispose();
    super.dispose();
  }
}
