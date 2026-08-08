import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/mark_chat_room_messages_as_read.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ChatRoomMessageEntity message(String senderId, {DateTime? readAt}) =>
      ChatRoomMessageEntity(
          roomId: 1,
          senderId: senderId,
          body: 'hi',
          sentAt: now,
          readAt: readAt);

  test('marks unread messages from the other participant as read', () {
    final other = message('vendor-1');
    final changed = MarkChatRoomMessagesAsRead.call([other], 'buyer-1', now);
    expect(changed, [other]);
    expect(other.readAt, now);
  });

  test('does not mark the reader\'s own messages as read', () {
    final own = message('buyer-1');
    final changed = MarkChatRoomMessagesAsRead.call([own], 'buyer-1', now);
    expect(changed, isEmpty);
    expect(own.readAt, isNull);
  });

  test('is idempotent for already-read messages', () {
    final alreadyRead = message('vendor-1', readAt: now.subtract(const Duration(hours: 1)));
    final changed =
        MarkChatRoomMessagesAsRead.call([alreadyRead], 'buyer-1', now);
    expect(changed, isEmpty);
  });
}
