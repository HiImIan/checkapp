import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class DialogTextfieldWidget extends StatelessWidget {
  final bool isTitle;
  final TextEditingController controller;
  const DialogTextfieldWidget({
    super.key,
    required this.isTitle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    final colors = theme.colorScheme;

    final l10n = LocalizationService.instance.l10n;

    final fieldTitle = isTitle ? l10n.title : l10n.description;
    final hintText = isTitle ? l10n.enterTitle : l10n.enterDescription;
    final masLines = isTitle ? 1 : 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: textStyle.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: masLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            hintText: hintText,
            hintStyle: textStyle.bodyLarge!.copyWith(
              color: colors.primaryFixed,
            ),
          ),
        ),
      ],
    );
  }
}
