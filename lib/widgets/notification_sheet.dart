import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';
import 'adaptive_text.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;

  const NotificationSheet({
    super.key,
    required this.notifications,
    required this.onRead,
  });

  // متد نمایش جزئیات کامل نوتیفیکیشن در یک Dialog شیشه‌ای
  void _showDetails(BuildContext context, AppNotification item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          title: AdaptiveText(
            item.title,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(
                item.body,
                style: const TextStyle(height: 1.6),
              ),
              const SizedBox(height: 20),
              AdaptiveText(
                "Source: ${item.footer}",
                fontSize: 10,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const AdaptiveText(
                "Close",
                style: TextStyle(
                    color: Colors.cyanAccent, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = AdaptiveTheme.of(context).mode.isDark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black.withOpacity(0.6)
                : Colors.white.withOpacity(0.6),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // دسته بالای منو (Drag Handle)
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: AdaptiveText(
                  "NOTIFICATIONS",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),

              Divider(
                color: isDarkMode ? Colors.white10 : Colors.black12,
                height: 1,
              ),

              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: AdaptiveText(
                          "No new notifications",
                          style: TextStyle(color: theme.hintColor),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return NotificationCard(
                            item: item,
                            onTap: () {
                              // ۱. علامت‌گذاری به عنوان خوانده شده
                              onRead(item);
                              // ۲. نمایش پنجره جزئیات
                              _showDetails(context, item);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
