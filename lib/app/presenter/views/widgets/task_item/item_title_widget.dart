import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:flutter/material.dart';

class ItemTitleWidget extends StatelessWidget {
  final TaskModel task;
  const ItemTitleWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final isCompleted = task.isCompleted;
    final titleDecoration = isCompleted ? TextDecoration.lineThrough : null;

    return Text(
      task.title,
      style: textStyle.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
        decoration: titleDecoration,
      ),
    );
  }
}
