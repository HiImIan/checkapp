import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TasksSearchWidget extends StatelessWidget {
  final bool isEnabled;
  final void Function(String)? onChange;
  const TasksSearchWidget({
    super.key,
    required this.isEnabled,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;
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
        enabled: isEnabled,
        style: textStyle.bodyLarge!.copyWith(color: colors.surfaceDim),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          hintText: l10n.searchTasks,
          hintStyle: textStyle.bodyLarge!.copyWith(
            color: colors.primaryFixedDim,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: colors.primaryFixedDim,

          border: InputBorder.none,
        ),

        onChanged: onChange,
      ),
    );
  }
}
