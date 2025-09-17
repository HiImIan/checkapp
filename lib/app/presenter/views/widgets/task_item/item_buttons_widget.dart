import 'package:flutter/material.dart';

class ItemButtonsWidget extends StatelessWidget {
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;
  const ItemButtonsWidget({
    super.key,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Row(
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
    );
  }
}
