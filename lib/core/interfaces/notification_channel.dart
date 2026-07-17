import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for the realtime half of the Notification Dispatcher (Issue
/// #71). A real implementation would check Redis for an active Socket.io
/// connection and fall back to the Firebase Admin SDK; callers stay
/// decoupled from which channel actually delivered the alert.
abstract class NotificationChannel {
  OmniResult<bool> isUserOnline();

  OmniResult<void> emitInApp(InboxNotificationEntity notification);

  OmniResult<void> sendPush(
      InboxNotificationEntity notification, String previewBody);
}
