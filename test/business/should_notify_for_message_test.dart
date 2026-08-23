import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_notify_for_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  ChatRoomMessageEntity message({required String senderId, bool isSilent = false}) =>
      ChatRoomMessageEntity(roomId: 1, senderId: senderId, body: 'hi', sentAt: now, isSilent: isSilent);

  group('ShouldNotifyForMessage', () {
    test('notifies for a normal message from another sender (Issue #317 feature #21)', () {
      expect(ShouldNotifyForMessage.call(message(senderId: 'vendor'), 'buyer'), isTrue);
    });

    test('does not notify for the current user\'s own echoed message', () {
      expect(ShouldNotifyForMessage.call(message(senderId: 'buyer'), 'buyer'), isFalse);
    });

    test('does not notify for a silent message from another sender', () {
      expect(ShouldNotifyForMessage.call(message(senderId: 'vendor', isSilent: true), 'buyer'), isFalse);
    });
  });
}
