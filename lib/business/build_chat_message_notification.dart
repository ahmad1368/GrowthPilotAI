import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

/// A single new-chat-message alert (Issue #137 AC: "generic professional
/// summaries" — never the message body itself, to avoid leaking PII into
/// a push preview). [metadataRefType]/[metadataRefId] carry the deep-link
/// target for the "Deep-Linking" AC.
class BuildChatMessageNotification {
  static InboxNotificationEntity call({
    required String senderId,
    required int roomId,
    required DateTime now,
  }) {
    return InboxNotificationEntity(
      title: 'New message',
      body: 'New message from $senderId',
      metadataRefType: 'ChatRoom',
      metadataRefId: roomId.toString(),
      createdAt: now,
    );
  }
}
