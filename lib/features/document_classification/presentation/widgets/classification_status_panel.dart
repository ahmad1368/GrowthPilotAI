import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ClassificationStatusPanel extends StatelessWidget {
  final bool isChecking;
  const ClassificationStatusPanel({super.key, required this.isChecking});

  @override
  Widget build(BuildContext context) {
    if (!isChecking) return const SizedBox.shrink();

    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: fgColor,
            strokeWidth: 2.5,
          ),
          const SizedBox(width: 16),
          Text(
            'Checking image quality...',
            style: theme.textTheme.p.copyWith(color: fgColor),
          ),
        ],
      ),
    );
  }
}
