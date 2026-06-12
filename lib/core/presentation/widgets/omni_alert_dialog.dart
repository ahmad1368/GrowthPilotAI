import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OmniAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const OmniAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShadDialog(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      title: Text(title, style: theme.textTheme.h4),
      description: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(message, style: theme.textTheme.p),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          text: const Text('بستن'), // تغییر نام child به text
        ),
        if (actionLabel != null)
          ShadButton(
            backgroundColor: const Color(0xff2563eb),
            text: Text(actionLabel!), // تغییر نام child به text
            onPressed: () {
              Navigator.of(context).pop();
              if (onAction != null) onAction!();
            },
          ),
      ],
    );
  }
}
