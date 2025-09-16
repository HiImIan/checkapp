import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class DialogButtonsWidget extends StatelessWidget {
  final void Function()? ontapSave;
  const DialogButtonsWidget({super.key, this.ontapSave});

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationService.instance.l10n;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: ontapSave,
            icon: Icon(Icons.save, color: colors.onPrimary),
            label: Text(
              l10n.save,
              style: textStyle.bodyLarge!.copyWith(color: colors.onPrimary),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primaryFixed,
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
