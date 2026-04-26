import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:growth_pilot_ai/widgets/glass_card.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;

  const NotificationSheet({
    super.key, 
    required this.notifications, 
    required this.onRead
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 30,
      blur: 25,
      opacity: 0.2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75, // کمی بلندتر برای دسترسی راحت‌تر
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            // دستگیره بالای منو برای حس درگ کردن
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Notifications",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Text("No notifications yet", 
                      style: TextStyle(color: Colors.white38)))
                  : ListView.builder(
                      itemCount: notifications.length,
                      padding: const EdgeInsets.only(bottom: 60), // فاصله برای دکمه‌های سیستم
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        return _buildNotificationItem(context, item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, AppNotification item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.transparent : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          onRead(item); // این فراخوانی باعث اجرای setSheetState در AppBar می‌شود
          _showDetailDialog(context, item);
        },
        // ۱. دایره نئونی که بلافاصله بعد از کلیک مخفی می‌شود
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.isRead ? Colors.transparent : Colors.cyanAccent,
            boxShadow: item.isRead ? [] : [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.6), 
                blurRadius: 10, 
                spreadRadius: 1
              )
            ],
          ),
        ),
        // ۲. فونت ضخیم برای موارد خوانده نشده
        title: Text(
          item.title,
          style: TextStyle(
            color: item.isRead ? Colors.white54 : Colors.white,
            fontWeight: item.isRead ? FontWeight.w400 : FontWeight.w900,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          item.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: item.isRead ? Colors.white24 : Colors.white38,
            fontSize: 13,
          ),
        ),
        trailing: Icon(
          item.isRead ? Icons.done_all_rounded : Icons.chevron_right_rounded,
          size: 18,
          color: item.isRead ? Colors.cyanAccent.withOpacity(0.3) : Colors.white12,
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, AppNotification item) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: FadeTransition(
            opacity: anim1,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: GlassCard(
                blur: 25,
                opacity: 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.notifications_active_outlined, 
                        color: Colors.cyanAccent, size: 50),
                      const SizedBox(height: 20),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Got it", 
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}