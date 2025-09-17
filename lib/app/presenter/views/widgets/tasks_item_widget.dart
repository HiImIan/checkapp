import 'package:checkapp/app/presenter/models/task_model.dart';
import 'package:checkapp/app/presenter/views/widgets/task_item/item_buttons_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/task_item/item_description_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/task_item/item_title_widget.dart';
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isCompleted = task.isCompleted;
    final icon = isCompleted
        ? Icons.check_circle
        : Icons.radio_button_unchecked;
    final iconColor = isCompleted
        ? colors.onTertiaryFixedVariant
        : colors.tertiary;

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
          title: ItemTitleWidget(task: task),
          subtitle: ItemDescriptionWidget(task: task),
          trailing: ItemButtonsWidget(
            onTapEdit: onTapEdit,
            onTapDelete: onTapDelete,
          ),
        ),
      ),
    );
  }
}
