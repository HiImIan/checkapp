import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/data/repositories/tasks_repository.dart';
import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

/// ViewModel that manages tasks state and business logic
class TasksViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final l10n = LocalizationService.instance.l10n;
  // Private state
  List<TaskModel> _tasks = [];
  int _selectedTab = 0;
  bool _isEditing = false;
  String? _editingTaskId;
  bool _isLoading = false;
  String? _error;

  TasksViewModel({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository;

  // Public getters
  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  int get selectedTab => _selectedTab;
  bool get isEditing => _isEditing;
  String? get editingTaskId => _editingTaskId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Returns filtered tasks by selected tab
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

  // Counters
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;

  /// Initializes repository and loads data
  Future<void> initialize() async {
    await _executeWithLoading(() async {
      await _tasksRepository.initialize();
      await _loadTasks();
    }, l10n.failedToInicialize);
  }

  /// Loads all tasks from repository
  Future<void> loadTasks() async {
    await _executeWithLoading(_loadTasks, l10n.failedToLoad);
  }

  //======================================
  //---------------- CRUD ----------------
  //======================================

  /// Saves task (adds new or updates existing)
  Future<void> saveTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    await _executeWithLoading(() async {
      if (_isEditing && _editingTaskId != null) {
        final updatedTask = _createUpdatedTask(title, description);
        await _tasksRepository.updateTask(updatedTask);
      } else {
        final newTask = _createNewTask(title, description);
        await _tasksRepository.addTask(newTask);
      }
      await _loadTasks();
      _clearForm();
    }, _isEditing ? l10n.failedToUpdate : l10n.failedToAdd);
  }

  /// Deletes a task
  Future<void> deleteTask(String taskId) async {
    await _executeWithLoading(() async {
      await _tasksRepository.deleteTask(taskId);
      await _loadTasks();
    }, l10n.failedToDelete);
  }

  /// Toggles task completion status
  Future<void> toggleTaskCompletion(String taskId) async {
    await _executeWithLoading(() async {
      await _tasksRepository.toggleTaskCompletion(taskId);
      await _loadTasks();
    }, l10n.failedToToggleStatus);
  }

  /// Searches tasks by query
  Future<void> searchTasks(String query) async {
    await _executeWithLoading(() async {
      _tasks = await _tasksRepository.searchTasks(query.trim());
    }, l10n.failedToSearch);
  }

  //======================================
  //----------- UI State -----------------
  //======================================

  /// Prepares state for adding new task
  void prepareAddTask() {
    _isEditing = false;
    _editingTaskId = null;
    _clearForm();
  }

  /// Prepares state for editing existing task
  void prepareEditTask(TaskModel task) {
    _isEditing = true;
    _editingTaskId = task.id;
    titleController.text = task.title;
    descriptionController.text = task.description;
    _clearError();
  }

  /// Sets selected tab
  void setSelectedTab(int tab) {
    if (_selectedTab != tab) {
      _selectedTab = tab;
      notifyListeners();
    }
  }

  //======================================
  //-------- Private Methods -------------
  //======================================

  /// Loads tasks from repository
  Future<void> _loadTasks() async {
    _tasks = await _tasksRepository.getAllTasks();
    notifyListeners();
  }

  /// Executes operation with loading and error control
  Future<void> _executeWithLoading(
    Future<void> Function() operation,
    String errorPrefix,
  ) async {
    _setLoading(true);
    _clearError();

    try {
      await operation();
    } catch (e) {
      _setError('$errorPrefix: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Creates new TaskModel instance
  TaskModel _createNewTask(String title, String description) {
    return TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now().toString(),
    );
  }

  /// Creates updated TaskModel preserving original data
  TaskModel _createUpdatedTask(String title, String description) {
    final existingTask = _tasks.firstWhere((task) => task.id == _editingTaskId);

    return existingTask.copyWith(
      title: title,
      description: description,
      createdAt: existingTask.createdAt,
      isCompleted: existingTask.isCompleted,
    );
  }

  /// Clears form fields
  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
    _clearError();
  }

  /// Sets loading state
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Sets error message
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  /// Clears current error
  void _clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _tasksRepository.dispose();
    super.dispose();
  }
}
