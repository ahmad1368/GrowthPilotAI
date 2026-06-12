import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'notification_card.dart';

class NotificationListView extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete;

  const NotificationListView({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final item = notifications[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: NotificationCard(
            item: item,
            onTap: () => onRead(item), // 💡 تطبیق دقیق با امضای onTap کارت
            onDelete: () =>
                onDelete(item), // 💡 تبدیل کالبک داده به VoidCallback
          ),
        );
      },
    );
  }
}
