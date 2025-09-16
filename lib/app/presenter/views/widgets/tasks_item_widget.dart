import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

class TasksItemWidget extends StatelessWidget {
  final TaskModel task;
  final void Function()? onTapCheck;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;
  const TasksItemWidget({
    super.key,
    required this.task,
    this.onTapCheck,
    this.onTapEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;

    final isCompleted = task.isCompleted;
    final icon = isCompleted
        ? Icons.check_circle
        : Icons.radio_button_unchecked;
    final iconColor = isCompleted
        ? colors.onTertiaryFixedVariant
        : colors.tertiary;
    final titleDecoration = isCompleted ? TextDecoration.lineThrough : null;

    final editedAt = task.editedAt;
    final hasEdited = editedAt != null;

    final editedText = isCompleted
        ? l10n.completedAt(editedAt ?? '-')
        : l10n.editedAt(editedAt ?? '-');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.onPrimary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colors.onSurfaceVariant,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTapCheck,
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Icon(icon, color: iconColor),
          title: Text(
            task.title,
            style: textStyle.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              decoration: titleDecoration,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description.isNotEmpty) ...[
                SizedBox(height: 4),
                Text(
                  task.description,
                  style: textStyle.bodyMedium!.copyWith(
                    color: colors.surfaceDim,
                  ),
                ),
              ],
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    l10n.createdAt(task.createdAt),
                    style: textStyle.bodySmall!.copyWith(
                      color: colors.surfaceDim,
                    ),
                  ),
                  if (hasEdited) ...[
                    SizedBox(width: 20),
                    Text(
                      editedText,
                      style: textStyle.bodySmall!.copyWith(
                        color: colors.surfaceDim,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onTapEdit,
                icon: Icon(Icons.edit, color: colors.tertiary),
              ),
              IconButton(
                onPressed: onTapDelete,
                icon: Icon(Icons.delete, color: colors.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
