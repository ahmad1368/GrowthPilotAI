import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScannerStatusDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const ScannerStatusDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ShadCard(
          backgroundColor:
              isDark ? const Color(0xff18181b) : const Color(0xffffffff),
          padding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, color: iconColor, size: 32),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.h4),
              const SizedBox(height: 8),
              Text(
                message,
                style: theme.textTheme.p,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadButton.outline(
                    text: const Text("انصراف"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  ShadButton(
                    backgroundColor: const Color(0xff2563eb),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onRetry();
                    },
                    text: const Text("اسکن مجدد سند"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
