import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Read Receipts (Issue #131 AC): marks every unread message from the
/// *other* participant as read when [readerId] views the room, mirroring
/// [MarkMessagesAsRead]'s idempotent, changed-only-return pattern.
class MarkChatRoomMessagesAsRead {
  static List<ChatRoomMessageEntity> call(
      List<ChatRoomMessageEntity> messages, String readerId, DateTime now) {
    final changed = <ChatRoomMessageEntity>[];
    for (final message in messages) {
      if (message.senderId == readerId || message.isRead) continue;
      message.readAt = now;
      changed.add(message);
    }
    return changed;
  }
}
