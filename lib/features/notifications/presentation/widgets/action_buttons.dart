import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ActionButtons extends StatelessWidget {
  final AppNotification item;
  final bool isDark;
  final VoidCallback onDelete;

  const ActionButtons(
      {super.key,
      required this.item,
      required this.isDark,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final statusColor =
        item.isRead ? const Color(0xff71717a) : const Color(0xff2563eb);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          item.isRead
              ? Icons.drafts_outlined
              : Icons.mark_email_unread_outlined,
          size: 18,
          color: statusColor,
        ),
        const SizedBox(width: 8),
        ShadButton.ghost(
          icon: const Icon(Icons.close_rounded,
              size: 18, color: Color(0xffef4444)),
          onPressed: onDelete,
          width: 32,
          height: 32,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
