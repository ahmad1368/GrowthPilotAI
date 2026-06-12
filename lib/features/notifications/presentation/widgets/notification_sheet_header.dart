import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NotificationSheetHeader extends StatelessWidget {
  const NotificationSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Column(
      children: [
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: fgColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "NOTIFICATIONS",
          style: ShadTheme.of(context).textTheme.h3.copyWith(
                color: fgColor,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 8),
        Divider(color: fgColor.withValues(alpha: 0.1), height: 1),
      ],
    );
  }
}
