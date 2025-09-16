import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:checkapp/app/presenter/views/widgets/exceptions/tasks_error_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/exceptions/tasks_load_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_appbar_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_filters_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_search_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_statistics_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_dialog_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_item_widget.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksPage({super.key, required this.tasksViewModel});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TasksViewModel get tasksViewModel => widget.tasksViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tasksViewModel.initialize();
    });
  }

  void _showAddTaskDialog() {
    tasksViewModel.prepareAddTask();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TasksDialogWidget(tasksViewModel: tasksViewModel),
    );
  }

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TasksAppbarWidget(),
      ),
      body: AnimatedBuilder(
        animation: tasksViewModel,
        builder: (_, __) {
          final isLoading = tasksViewModel.isLoading;
          if (isLoading) return TasksLoadWidget();

          final error = tasksViewModel.error;
          if (error != null) return TasksErrorWidget(error: error);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // Row with list's counters
                    TasksStatisticsWidget(tasksViewModel: tasksViewModel),
                    SizedBox(height: 20),
                    // Textfield
                    TasksSearchWidget(tasksViewModel: tasksViewModel),
                    SizedBox(height: 20),
                    // Filter tabs
                    TasksFiltersWidget(tasksViewModel: tasksViewModel),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Tasks list
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: length,
                  itemBuilder: (_, index) {
                    final task = tasksViewModel.filteredTasks[index];

                    final isLargeList =
                        tasksViewModel.filteredTasks.length >= 20;
                    final isNearLastItem = index == length - 3;
                    if (isLargeList && isNearLastItem) {
                      //TODO fazer lista carregar conforme proximidade do fim da lista
                    }
                    return TasksItemWidget(
                      task: task,
                      onTapCheck: () =>
                          tasksViewModel.toggleTaskCompletion(task.id),
                      onTapEdit: () => _showEditTaskDialog(task),
                      onTapDelete: () => tasksViewModel.deleteTask(task.id),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
