import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/batch_chat_notifications.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  test('creates a new notification when there is no unread one for the room', () {
    final result = BatchChatNotifications.call([], 'vendor-1', 5, now);
    expect(result.metadataRefId, '5');
    expect(result.body, 'New message from vendor-1');
  });

  test('collapses a second message from the same room into a count summary', () {
    final first = BatchChatNotifications.call([], 'vendor-1', 5, now);
    final result = BatchChatNotifications.call([first], 'vendor-1', 5, now);

    expect(identical(result, first), isTrue);
    expect(result.body, '2 new messages from vendor-1');
  });

  test('increments the count again on a third message', () {
    final first = BatchChatNotifications.call([], 'vendor-1', 5, now);
    final second = BatchChatNotifications.call([first], 'vendor-1', 5, now);
    final third = BatchChatNotifications.call([second], 'vendor-1', 5, now);

    expect(third.body, '3 new messages from vendor-1');
  });

  test('does not batch across different rooms', () {
    final first = BatchChatNotifications.call([], 'vendor-1', 5, now);
    final result = BatchChatNotifications.call([first], 'vendor-1', 6, now);

    expect(identical(result, first), isFalse);
    expect(result.metadataRefId, '6');
  });

  test('does not batch into an already-read notification', () {
    final first = BatchChatNotifications.call([], 'vendor-1', 5, now)..isRead = true;
    final result = BatchChatNotifications.call([first], 'vendor-1', 5, now);

    expect(identical(result, first), isFalse);
  });
}
