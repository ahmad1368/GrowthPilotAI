import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NotificationDetailDialog extends StatelessWidget {
  final AppNotification item;
  const NotificationDetailDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShadDialog(
      title: Text(
        item.title,
        style: ShadTheme.of(context).textTheme.h4,
      ),
      description: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          item.body,
          style: ShadTheme.of(context).textTheme.p.copyWith(
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.7),
              ),
        ),
      ),
      actions: [
        ShadButton(
          backgroundColor:
              isDark ? const Color(0xffffffff) : const Color(0xff09090b),
          onPressed: () => Navigator.pop(context),
          text: Text(
            "Understand Insight",
            style: TextStyle(color: isDark ? Colors.black : Colors.white),
          ),
        ),
      ],
    );
  }
}
