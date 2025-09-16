import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TasksAppbarWidget extends StatelessWidget {
  const TasksAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final l10n = LocalizationService.instance.l10n;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.secondary],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.tasksManager, style: textStyle.headlineSmall),
      ),
    );
  }
}
