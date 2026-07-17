import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for Socket.io presence + Firebase push (Issue #71).
/// Always reports the user online so in-app delivery is exercised by
/// default; web-safe (no native FCM SDK call).
class MockNotificationChannel implements NotificationChannel {
  @override
  OmniResult<bool> isUserOnline() async => OmniResponse.success(true);

  @override
  OmniResult<void> emitInApp(InboxNotificationEntity notification) async {
    OmniLogger.info('In-app notification: ${notification.title}');
    return OmniResponse.success(null);
  }

  @override
  OmniResult<void> sendPush(
      InboxNotificationEntity notification, String previewBody) async {
    OmniLogger.info('Push notification: ${notification.title} — $previewBody');
    return OmniResponse.success(null);
  }
}
