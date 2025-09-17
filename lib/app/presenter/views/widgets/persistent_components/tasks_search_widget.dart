import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:flutter/material.dart';

class TasksSearchWidget extends StatelessWidget {
  final TasksViewModel tasksViewModel;
  const TasksSearchWidget({super.key, required this.tasksViewModel});

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final isEnabled = tasksViewModel.totalTasks > 0;
    final searchController = tasksViewModel.searchController;
    final hasNoSearch = searchController.text.isEmpty;
    final enabledColor = isEnabled ? colors.primary : colors.onSurfaceVariant;
    final suffixIcon = hasNoSearch
        ? null
        : IconButton(
            onPressed: tasksViewModel.clearSearchTask,
            icon: Icon(Icons.close),
          );
    return Container(
      decoration: BoxDecoration(
        color: colors.onPrimary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: colors.onSurfaceVariant,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        enabled: isEnabled,
        style: textStyle.bodyLarge!.copyWith(color: colors.surfaceDim),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          hintText: l10n.searchTasks,
          hintStyle: textStyle.bodyLarge!.copyWith(
            color: enabledColor,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: enabledColor,
          suffixIcon: suffixIcon,
          suffixIconColor: colors.primary,

          border: InputBorder.none,
        ),

        onChanged: tasksViewModel.searchTasks,
      ),
    );
  }
}
