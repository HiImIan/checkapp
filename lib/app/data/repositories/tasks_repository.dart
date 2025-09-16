import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TasksRepository {
  Future<void> initialize();
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskCompletion(String id);
  Future<List<TaskModel>> searchTasks(String query);
  Future<void> dispose();
}

class TasksRepositoryImpl implements TasksRepository {
  static const String _boxName = 'tasks_box';
  Box<TaskModel>? _box;

  Box<TaskModel> get _taskBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Repositório não inicializado.');
    }
    return _box!;
  }

  @override
  Future<void> initialize() async {
    try {
      await Hive.initFlutter();

      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskModelAdapter());
      }

      _box = await Hive.openBox<TaskModel>(_boxName);
    } catch (e) {
      throw Exception('Erro ao inicializar repositório: $e');
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final box = _taskBox;
      final tasks = box.values.toList();

      tasks.sort(
        (a, b) => _parseDate(
          b.editedAt ?? b.createdAt,
        ).compareTo(_parseDate(a.editedAt ?? a.createdAt)),
      );

      return tasks;
    } catch (e) {
      throw Exception('Erro ao carregar tarefas: $e');
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      final box = _taskBox;
      await box.put(task.id, task);
    } catch (e) {
      throw Exception('Erro ao adicionar tarefa: $e');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      final box = _taskBox;

      if (!box.containsKey(task.id)) {
        throw Exception('Tarefa não encontrada para atualização');
      }

      await box.put(task.id, task);
    } catch (e) {
      throw Exception('Erro ao atualizar tarefa: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      final box = _taskBox;

      if (!box.containsKey(id)) {
        throw Exception('Tarefa não encontrada para exclusão');
      }

      await box.delete(id);
    } catch (e) {
      throw Exception('Erro ao deletar tarefa: $e');
    }
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    try {
      final box = _taskBox;
      final task = box.get(id);

      if (task == null) {
        throw Exception('Tarefa não encontrada para alteração de status');
      }

      final now = DateTime.now();
      final dateStr =
          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

      final updatedTask = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        createdAt: task.createdAt,
        editedAt: dateStr,
        isCompleted: !task.isCompleted,
      );

      await box.put(id, updatedTask);
    } catch (e) {
      throw Exception('Erro ao alterar status da tarefa: $e');
    }
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    try {
      final box = _taskBox;
      final lowercaseQuery = query.toLowerCase().trim();

      if (lowercaseQuery.isEmpty) {
        return getAllTasks();
      }

      final filteredTasks = box.values.where((task) {
        return task.title.toLowerCase().contains(lowercaseQuery) ||
            task.description.toLowerCase().contains(lowercaseQuery);
      }).toList();

      filteredTasks.sort((a, b) {
        final aTitleMatch = a.title.toLowerCase().contains(lowercaseQuery);
        final bTitleMatch = b.title.toLowerCase().contains(lowercaseQuery);

        if (aTitleMatch && !bTitleMatch) return -1;
        if (!aTitleMatch && bTitleMatch) return 1;

        return _parseDate(
          b.editedAt ?? b.createdAt,
        ).compareTo(_parseDate(a.editedAt ?? a.createdAt));
      });

      return filteredTasks;
    } catch (e) {
      throw Exception('Erro ao buscar tarefas: $e');
    }
  }

  @override
  Future<void> dispose() async => await _box?.close();

  DateTime _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length != 3) return DateTime.now();

      return DateTime(
        int.parse(parts[2]), // year
        int.parse(parts[1]), // month
        int.parse(parts[0]), // day
      );
    } catch (e) {
      return DateTime.now();
    }
  }
}
