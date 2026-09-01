import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/mark_messages_as_read.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';

MessageEntity _message({required bool isRead}) => MessageEntity(
      conversationId: 1,
      senderId: 'system',
      body: 'hello',
      isRead: isRead,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  final now = DateTime(2026, 1, 15, 10);

  test('marks unread messages as read and stamps readAt', () {
    final unread = _message(isRead: false);

    final changed = MarkMessagesAsRead.call([unread], now);

    expect(changed, [unread]);
    expect(unread.isRead, isTrue);
    expect(unread.readAt, now);
  });

  test('leaves already-read messages untouched and out of the changed list', () {
    final read = _message(isRead: true);

    final changed = MarkMessagesAsRead.call([read], now);

    expect(changed, isEmpty);
    expect(read.readAt, isNull);
  });

  test('only returns the messages that actually changed, in a mixed batch', () {
    final unread = _message(isRead: false);
    final read = _message(isRead: true);

    final changed = MarkMessagesAsRead.call([read, unread], now);

    expect(changed, [unread]);
  });
}
