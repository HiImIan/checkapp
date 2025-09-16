import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TasksLoadWidget extends StatelessWidget {
  const TasksLoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final l10n = LocalizationService.instance.l10n;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.loading,
            textAlign: TextAlign.center,
            style: textStyle.titleLarge,
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(color: colors.primary),
        ],
      ),
    );
  }
}
