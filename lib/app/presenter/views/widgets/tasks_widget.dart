import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:checkapp/app/presenter/views/widgets/exceptions/tasks_error_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/exceptions/tasks_load_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/exceptions/tasks_no_item_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_dialog_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_item_widget.dart';
import 'package:flutter/material.dart';

class TasksWidget extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksWidget({super.key, required this.tasksViewModel});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksViewModel get tasksViewModel => widget.tasksViewModel;
  void _showEditTaskDialog(TaskModel task) {
    tasksViewModel.prepareEditTask(task);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TasksDialogWidget(tasksViewModel: tasksViewModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final length = tasksViewModel.filteredTasks.length;

    final error = tasksViewModel.error;
    final isLoading = tasksViewModel.isLoading;
    if (isLoading) return TasksLoadWidget();
    if (error != null) return TasksErrorWidget(error: error);
    return Visibility(
      visible: length != 0,
      replacement: TasksNoItemWidget(),
      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: length,
          itemBuilder: (_, index) {
            final task = tasksViewModel.filteredTasks[index];
            return TasksItemWidget(
              task: task,
              onTapCheck: () => tasksViewModel.toggleTaskCompletion(task.id),
              onTapEdit: () => _showEditTaskDialog(task),
              onTapDelete: () => tasksViewModel.deleteTask(task.id),
            );
          },
        ),
      ),
    );
  }
}
