import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                // نمایش ساعت از روی فیلد DateTime
                Text(
                    "${item.date.hour}:${item.date.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 8),
            // حتما از فیلد body استفاده کن (نه message)
            Text(item.body,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 13, height: 1.4)),
            if (item.footer.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(item.footer,
                  style: const TextStyle(color: Colors.white24, fontSize: 10)),
            ]
          ],
        ),
      ),
    );
  }
}
