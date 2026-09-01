import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';

/// "Bulk Mark as Read" (Issue #78): marks every currently-unread message in
/// a thread as read, stamping [MessageEntity.readAt] for the "Read N mins
/// ago" metadata the issue calls for. Returns only the messages that
/// actually changed, so the caller persists the minimum necessary writes.
class MarkMessagesAsRead {
  static List<MessageEntity> call(List<MessageEntity> messages, DateTime now) {
    final changed = <MessageEntity>[];
    for (final message in messages) {
      if (message.isRead) continue;
      message.isRead = true;
      message.readAt = now;
      changed.add(message);
    }
    return changed;
  }
}
