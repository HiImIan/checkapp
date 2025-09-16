import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksPage({super.key, required this.tasksViewModel});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<TaskModel> tasks = [
    TaskModel(
      id: '1',
      title: 'titulo',
      subtitle: 'descrição',
      createdAt: '15/09/2025',
      editedAt: '15/09/2025',
      isCompleted: false,
    ),
  ];

  int selectedTab = 0;
  bool showEditDialog = false;
  bool isEditing = false;
  String? editingTaskId;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF69B4), Color(0xFF8B5CF6)],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Gerenciador de Tarefas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Color(0xFFF5F5F5),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.view_list,
                        number: tasks.length.toString(),
                        label: 'Total',
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.radio_button_unchecked,
                        number: tasks
                            .where((t) => !t.isCompleted)
                            .length
                            .toString(),
                        label: 'Pendentes',
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.check_circle_outline,
                        number: tasks
                            .where((t) => t.isCompleted)
                            .length
                            .toString(),
                        label: 'Concluídas',
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFF5F5F5),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar tarefas...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            _buildTabButton('Todas (${tasks.length})', 0),
                            _buildTabButton(
                              'Pendentes (${tasks.where((t) => !t.isCompleted).length})',
                              1,
                            ),
                            _buildTabButton(
                              'Concluídas (${tasks.where((t) => t.isCompleted).length})',
                              2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: _getFilteredTasks().length,
                          itemBuilder: (context, index) {
                            final task = _getFilteredTasks()[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(15),
                                leading: GestureDetector(
                                  onTap: () => _toggleTaskCompletion(task.id),
                                  child: Icon(
                                    task.isCompleted
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: task.isCompleted
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 24,
                                  ),
                                ),
                                title: Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (task.subtitle.isNotEmpty) ...[
                                      SizedBox(height: 4),
                                      Text(
                                        task.subtitle,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Criado em\n${task.createdAt}',
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          '• Editado em\n${task.editedAt}',
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _showEditTaskDialog(task),
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _deleteTask(task.id),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (showEditDialog) _buildEditDialog(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Color(0xFFFF69B4),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEditDialog() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Editar Tarefa' : 'Nova Tarefa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: _closeDialog, icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Título *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFF69B4), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    hintText: 'Digite o título',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Descrição (opcional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Digite a descrição',
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _saveTask,
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text(
                        'Salvar Alterações',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF69B4),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _closeDialog,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String number,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFF5F5F5) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.black87 : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  List<TaskModel> _getFilteredTasks() {
    switch (selectedTab) {
      case 1:
        return tasks.where((task) => !task.isCompleted).toList();
      case 2:
        return tasks.where((task) => task.isCompleted).toList();
      default:
        return tasks;
    }
  }

  void _showAddTaskDialog() {
    setState(() {
      isEditing = false;
      editingTaskId = null;
      titleController.clear();
      descriptionController.clear();
      showEditDialog = true;
    });
  }

  void _showEditTaskDialog(TaskModel task) {
    setState(() {
      isEditing = true;
      editingTaskId = task.id;
      titleController.text = task.title;
      descriptionController.text = task.subtitle;
      showEditDialog = true;
    });
  }

  void _closeDialog() {
    setState(() {
      showEditDialog = false;
      titleController.clear();
      descriptionController.clear();
    });
  }

  void _saveTask() {
    if (titleController.text.trim().isEmpty) return;

    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    setState(() {
      if (isEditing && editingTaskId != null) {
        final taskIndex = tasks.indexWhere((t) => t.id == editingTaskId);
        if (taskIndex != -1) {
          tasks[taskIndex] = TaskModel(
            id: editingTaskId!,
            title: titleController.text.trim(),
            subtitle: descriptionController.text.trim(),
            createdAt: tasks[taskIndex].createdAt,
            editedAt: dateStr,
            isCompleted: tasks[taskIndex].isCompleted,
          );
        }
      } else {
        tasks.add(
          TaskModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: titleController.text.trim(),
            subtitle: descriptionController.text.trim(),
            createdAt: dateStr,
            editedAt: dateStr,
            isCompleted: false,
          ),
        );
      }
      showEditDialog = false;
      titleController.clear();
      descriptionController.clear();
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
    });
  }

  void _toggleTaskCompletion(String taskId) {
    setState(() {
      final taskIndex = tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex != -1) {
        final now = DateTime.now();
        final dateStr =
            '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

        tasks[taskIndex] = TaskModel(
          id: tasks[taskIndex].id,
          title: tasks[taskIndex].title,
          subtitle: tasks[taskIndex].subtitle,
          createdAt: tasks[taskIndex].createdAt,
          editedAt: dateStr,
          isCompleted: !tasks[taskIndex].isCompleted,
        );
      }
    });
  }
}
