import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReceiptScannerResultPanel extends StatelessWidget {
  final bool isDark;
  final ShadThemeData theme;

  const ReceiptScannerResultPanel({
    super.key,
    required this.isDark,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(15.0),
      content: Row(
        children: [
          Icon(Icons.auto_awesome_rounded,
              color:
                  isDark ? const Color(0xfff59e0b) : const Color(0xffd97706)),
          const SizedBox(width: 12),
          Expanded(
            child: Text('در انتظار تصویر برای استخراج متنی...',
                style: theme.textTheme.p),
          ),
        ],
      ),
    );
  }
}
