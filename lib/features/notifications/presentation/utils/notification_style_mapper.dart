import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

class NotificationStyleMapper {
  static Map<String, dynamic> getStyle(NotificationType type) {
    switch (type) {
      case NotificationType.danger:
        return {
          'icon': Icons.dangerous_rounded,
          'color': const Color(0xffef4444)
        };
      case NotificationType.warning:
        return {
          'icon': Icons.warning_amber_rounded,
          'color': const Color(0xfff59e0b)
        };
      case NotificationType.reminder:
        return {
          'icon': Icons.notifications_active_rounded,
          'color': const Color(0xff3b82f6)
        };
      case NotificationType.alert:
        return {
          'icon': Icons.emergency_share_rounded,
          'color': const Color(0xff06b6d4)
        };
      default:
        return {
          'icon': Icons.info_outline_rounded,
          'color': const Color(0xff71717a)
        };
    }
  }
}
