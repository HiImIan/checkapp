import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_appbar_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_filters_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_search_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/persistent_components/tasks_statistics_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_dialog_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/tasks_widget.dart';
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

    if (tasksViewModel.error == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => TasksDialogWidget(tasksViewModel: tasksViewModel),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = tasksViewModel.error != null;
    final floatingIcon = !hasError ? Icons.add : Icons.replay_outlined;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TasksAppbarWidget(),
      ),
      body: ListenableBuilder(
        listenable: tasksViewModel,
        builder: (_, __) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // Row with list's counters
                    TasksStatisticsWidget(tasksViewModel: tasksViewModel),
                    SizedBox(height: 20),
                    // Textfield
                    if (!hasError) ...[
                      TasksSearchWidget(tasksViewModel: tasksViewModel),
                      SizedBox(height: 20),
                    ],
                    // Filter tabs
                    TasksFiltersWidget(tasksViewModel: tasksViewModel),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Tasks list
              TasksWidget(tasksViewModel: tasksViewModel),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(floatingIcon),
      ),
    );
  }
}
