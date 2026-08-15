import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

/// Foreground "Rich Notification" banner (Issue #160) — this offline-first
/// client has no FCM/service-worker background delivery, so this is the
/// in-app stand-in for the issue's "Foreground Logic: show as a Toast
/// inside the UI, not a system-level pop-up" AC. Flat surface per this
/// app's design system, not the issue's literal Glassmorphism ask.
class RichNotificationBanner {
  static void show(InboxNotificationEntity notification) {
    final isDark = Get.isDarkMode;
    final fg = isDark ? Colors.white : Colors.black;

    Get.rawSnackbar(
      titleText: Text(notification.title, style: TextStyle(fontWeight: FontWeight.bold, color: fg)),
      messageText: Text(notification.body, style: TextStyle(color: fg.withValues(alpha: 0.7))),
      icon: notification.imageUrl == null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(notification.imageUrl!, width: 40, height: 40, fit: BoxFit.cover),
            ),
      mainButton: notification.actionLabel == null
          ? null
          : TextButton(onPressed: () => _handleTap(notification), child: Text(notification.actionLabel!)),
      onTap: (_) => _handleTap(notification),
      backgroundColor: isDark ? const Color(0xFF18181B) : Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }

  static void _handleTap(InboxNotificationEntity notification) {
    final route = notification.deepLinkRoute;
    if (route != null) Get.toNamed(route);
  }
}
