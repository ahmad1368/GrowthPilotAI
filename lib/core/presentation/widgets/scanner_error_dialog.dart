import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScannerErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ScannerErrorDialog(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              Icon(Icons.warning_amber_rounded,
                  color: isDark ? Colors.white : Colors.black, size: 30),
              const SizedBox(height: 16),
              Text("پردازش ناموفق", style: theme.textTheme.h4),
              const SizedBox(height: 8),
              Text(message,
                  style: theme.textTheme.p, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadButton.outline(
                    onPressed: () => Navigator.of(context).pop(),
                    text: const Text("انصراف"), // تغییر نام child به text
                  ),
                  const SizedBox(width: 12),
                  ShadButton(
                    backgroundColor: const Color(0xff2563eb),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onRetry();
                    },
                    text: const Text("اسکن مجدد"),
                  ),
                  // تغییر نام پارامتر child به text در دکمهٔ والد                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
