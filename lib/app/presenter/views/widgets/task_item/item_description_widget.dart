import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

class ItemDescriptionWidget extends StatelessWidget {
  final TaskModel task;
  const ItemDescriptionWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final l10n = LocalizationService.instance.l10n;

    final editedAt = task.editedAt;
    final hasEdited = editedAt != null;

    final editedText = task.isCompleted
        ? l10n.completedAt(editedAt ?? '-')
        : l10n.editedAt(editedAt ?? '-');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.description.isNotEmpty) ...[
          SizedBox(height: 4),
          Text(
            task.description,
            style: textStyle.bodyMedium!.copyWith(color: colors.surfaceDim),
          ),
        ],
        SizedBox(height: 8),
        // date times
        Row(
          children: [
            Text(
              l10n.createdAt(task.createdAt),
              style: textStyle.bodySmall!.copyWith(color: colors.surfaceDim),
            ),
            if (hasEdited) ...[
              SizedBox(width: 20),
              Text(
                editedText,
                style: textStyle.bodySmall!.copyWith(color: colors.surfaceDim),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
