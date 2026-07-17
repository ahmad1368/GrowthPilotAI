import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

/// "Notification Fatigue" guard (Issue #71): at most 5 non-critical alerts
/// per hour. Critical/high-priority alerts are never throttled.
class NotificationRateLimiter {
  static const maxNonCriticalPerHour = 5;

  static bool allows(
    List<InboxNotificationEntity> recentHistory,
    NotificationPriority priority,
    DateTime now,
  ) {
    final isUrgent = priority == NotificationPriority.high ||
        priority == NotificationPriority.critical;
    if (isUrgent) return true;

    final cutoff = now.subtract(const Duration(hours: 1));
    final recentNonCritical = recentHistory
        .where((n) => n.createdAt.isAfter(cutoff) && !n.isCritical)
        .length;
    return recentNonCritical < maxNonCriticalPerHour;
  }
}
