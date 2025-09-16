import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:checkapp/app/presenter/views/widgets/dialog/dialog_buttons_widget.dart';
import 'package:checkapp/app/presenter/views/widgets/dialog/dialog_textfield_widget.dart';
import 'package:flutter/material.dart';

class TasksDialogWidget extends StatefulWidget {
  final TasksViewModel tasksViewModel;
  const TasksDialogWidget({super.key, required this.tasksViewModel});

  @override
  State<TasksDialogWidget> createState() => _TasksDialogWidgetState();
}

class _TasksDialogWidgetState extends State<TasksDialogWidget> {
  TasksViewModel get tasksViewModel => widget.tasksViewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final colors = theme.colorScheme;

    final text = tasksViewModel.isEditing ? l10n.editTask : l10n.newTask;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: textStyle.titleLarge),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
            autofocus: true,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.primary),
              iconColor: WidgetStatePropertyAll(colors.onPrimary),
            ),
          ),
        ],
      ),
      content: Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            DialogTextfieldWidget(
              isTitle: true,
              controller: tasksViewModel.titleController,
            ),
            SizedBox(height: 20),
            DialogTextfieldWidget(
              isTitle: false,
              controller: tasksViewModel.descriptionController,
            ),
            if (tasksViewModel.error != null) ...[
              SizedBox(height: 10),
              Text(
                tasksViewModel.error!,
                style: textStyle.bodySmall!.copyWith(color: colors.error),
              ),
            ],
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: tasksViewModel.titleController,
              builder: (__, fieldValue, ___) {
                final hasNoTitle = fieldValue.text.isEmpty;
                return DialogButtonsWidget(
                  ontapSave: hasNoTitle
                      ? null
                      : () {
                          tasksViewModel.saveTask();
                          if (mounted && tasksViewModel.error == null) {
                            Navigator.of(context).pop();
                          }
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
