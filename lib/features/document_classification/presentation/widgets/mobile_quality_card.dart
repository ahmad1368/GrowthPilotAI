import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MobileQualityCard extends StatelessWidget {
  final String statusText;
  const MobileQualityCard({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.center_focus_strong_rounded, color: fgColor, size: 28),
          const SizedBox(height: 12),
          Text(statusText, style: theme.textTheme.p),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            backgroundColor: fgColor.withValues(alpha: 0.1),
            color: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
