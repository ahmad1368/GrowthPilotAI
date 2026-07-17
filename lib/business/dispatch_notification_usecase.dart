import 'package:growth_pilot_ai/business/decide_notification_delivery.dart';
import 'package:growth_pilot_ai/business/notification_rate_limiter.dart';
import 'package:growth_pilot_ai/business/sanitize_push_preview.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/notification_delivery_channel.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Orchestrates one notification's delivery (Issue #71): throttle check,
/// online/priority-based channel decision, then emits to whichever
/// channel(s) apply. Returns null when the alert was throttled.
class DispatchNotificationUseCase {
  final NotificationChannel _channel;

  DispatchNotificationUseCase(this._channel);

  Future<InboxNotificationEntity?> dispatch(
    InboxNotificationEntity notification,
    List<InboxNotificationEntity> recentHistory,
  ) async {
    if (!NotificationRateLimiter.allows(
        recentHistory, notification.priority, DateTime.now())) {
      OmniLogger.warning('Notification throttled: ${notification.title}');
      return null;
    }

    final isOnline = (await _channel.isUserOnline()).data ?? false;
    final channels = DecideNotificationDelivery.call(
        isOnline: isOnline, priority: notification.priority);

    if (channels.contains(NotificationDeliveryChannel.inApp)) {
      await _channel.emitInApp(notification);
    }
    if (channels.contains(NotificationDeliveryChannel.push)) {
      await _channel.sendPush(
          notification, SanitizePushPreview.call(notification.body));
      notification.deliveredViaPush = true;
    }
    return notification;
  }
}
