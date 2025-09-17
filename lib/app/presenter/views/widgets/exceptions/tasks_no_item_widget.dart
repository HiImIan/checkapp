import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TasksNoItemWidget extends StatelessWidget {
  const TasksNoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final l10n = LocalizationService.instance.l10n;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          l10n.addFirstTask,
          textAlign: TextAlign.center,
          style: textStyle.titleSmall,
        ),
      ),
    );
  }
}
