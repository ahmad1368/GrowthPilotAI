import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesktopQualityCard extends StatelessWidget {
  final String statusText;
  const DesktopQualityCard({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.document_scanner_rounded,
            color: isDark ? const Color(0xffffffff) : const Color(0xff09090b),
          ),
          const SizedBox(width: 16),
          Text(
            statusText,
            style: theme.textTheme.p.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
