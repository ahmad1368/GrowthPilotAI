import 'package:growth_pilot_ai/core/enum/notification_delivery_channel.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

/// Multi-channel dispatch decision (Issue #71): in-app while the user is
/// online, push whenever they're offline or the alert is HIGH/CRITICAL
/// (so a fraud alert still reaches a phone that's technically connected
/// but backgrounded).
class DecideNotificationDelivery {
  static Set<NotificationDeliveryChannel> call({
    required bool isOnline,
    required NotificationPriority priority,
  }) {
    final isUrgent = priority == NotificationPriority.high ||
        priority == NotificationPriority.critical;
    return {
      if (isOnline) NotificationDeliveryChannel.inApp,
      if (!isOnline || isUrgent) NotificationDeliveryChannel.push,
    };
  }
}
