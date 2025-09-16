import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:flutter/material.dart';

class TasksStatisticsWidget extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksStatisticsWidget({super.key, required this.tasksViewModel});

  @override
  State<TasksStatisticsWidget> createState() => _TasksStatisticsWidgetState();
}

class _TasksStatisticsWidgetState extends State<TasksStatisticsWidget> {
  TasksViewModel get tasksViewModel => widget.tasksViewModel;
  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.view_list,
            number: tasksViewModel.totalTasks.toString(),
            label: l10n.total,
            color: colors.primary,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            icon: Icons.radio_button_unchecked,
            number: tasksViewModel.pendingTasks.toString(),
            label: l10n.pendent,
            color: colors.tertiary,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_outline,
            number: tasksViewModel.completedTasks.toString(),
            label: l10n.completed,
            color: colors.onTertiaryFixedVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String number,
    required String label,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colors.onSurfaceVariant,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(number, style: textStyle.bodyLarge),
          Text(
            label,
            style: textStyle.bodySmall!.copyWith(color: colors.surfaceDim),
          ),
        ],
      ),
    );
  }
}
