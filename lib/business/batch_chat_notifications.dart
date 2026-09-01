import 'package:growth_pilot_ai/business/build_chat_message_notification.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

/// "Intelligent Batching" (Issue #137 AC): collapses consecutive unread
/// messages from the same room into one updated summary instead of a
/// growing pile of separate alerts, to avoid "Alert Fatigue".
class BatchChatNotifications {
  static InboxNotificationEntity call(
    List<InboxNotificationEntity> recentHistory,
    String senderId,
    int roomId,
    DateTime now,
  ) {
    final existing = recentHistory
        .where((n) =>
            !n.isRead && n.metadataRefType == 'ChatRoom' && n.metadataRefId == roomId.toString())
        .firstOrNull;

    if (existing == null) {
      return BuildChatMessageNotification.call(senderId: senderId, roomId: roomId, now: now);
    }
    final count = _leadingCount(existing.body) + 1;
    existing.body = '$count new messages from $senderId';
    existing.createdAt = now;
    return existing;
  }

  static int _leadingCount(String body) {
    final match = RegExp(r'^(\d+)').firstMatch(body);
    return match == null ? 1 : int.parse(match.group(1)!);
  }
}
