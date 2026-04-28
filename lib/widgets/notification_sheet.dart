import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;

  const NotificationSheet({
    super.key,
    required this.notifications,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    // محاسبه ارتفاع مناسب (مثلاً ۸۰٪ صفحه)
    double sheetHeight = MediaQuery.of(context).size.height * 0.8;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A).withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // دستگیره بالای منو
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white24, borderRadius: BorderRadius.circular(2)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("اعلان‌ها",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          const Divider(color: Colors.white10, height: 1),

          // بخش لیست ۱۲ تایی
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  item: notifications[index],
                  onTap: () => onRead(notifications[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
