import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_content_container.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_sheet_header.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete;

  const NotificationSheet({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff09090b) : const Color(0xffffffff),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          const NotificationSheetHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: NotificationContentContainer(
              notifications: notifications,
              onRead: onRead,
              onDelete: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
