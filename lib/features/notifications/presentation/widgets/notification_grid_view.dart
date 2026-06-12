import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'notification_card.dart';

class NotificationGridView extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete;

  const NotificationGridView({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 140,
      ),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final item = notifications[index];
        return NotificationCard(
          item: item,
          onTap: () =>
              onRead(item), // 💡 اصلاح پارامتر به onTap و تبدیل به VoidCallback
          onDelete: () => onDelete(
              item), // 💡 تبدیل کالبک داده به VoidCallback مورد نیاز کارت
        );
      },
    );
  }
}
