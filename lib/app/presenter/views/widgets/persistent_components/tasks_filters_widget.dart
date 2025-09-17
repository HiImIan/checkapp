import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:flutter/material.dart';

class TasksFiltersWidget extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksFiltersWidget({super.key, required this.tasksViewModel});

  @override
  State<TasksFiltersWidget> createState() => _TasksFiltersWidgetState();
}

class _TasksFiltersWidgetState extends State<TasksFiltersWidget> {
  TasksViewModel get tasksViewModel => widget.tasksViewModel;
  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;

    final allTasks = tasksViewModel.totalTasks.toString();
    final pendingTasks = tasksViewModel.pendingTasks.toString();
    final completedTasks = tasksViewModel.completedTasks.toString();
    return Row(
      children: [
        _buildTabButton(index: 0, text: l10n.allTasksValue(allTasks)),
        _buildTabButton(index: 1, text: l10n.pendentTasksValue(pendingTasks)),
        _buildTabButton(
          index: 2,
          text: l10n.completedtTasksValue(completedTasks),
        ),
      ],
    );
  }

  Widget _buildTabButton({required String text, required int index}) {
    bool isSelected = tasksViewModel.selectedTab == index;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final backgroundColor = isSelected
        ? colors.surfaceContainer
        : Colors.transparent;
    final fontWeight = isSelected ? FontWeight.bold : null;
    final textColor = isSelected ? colors.onSurface : colors.surfaceDim;
    return Expanded(
      child: GestureDetector(
        onTap: () => tasksViewModel.setSelectedTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle.bodyMedium!.copyWith(
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
