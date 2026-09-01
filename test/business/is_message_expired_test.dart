import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_message_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

ChatRoomMessageEntity _msg({DateTime? selfDestructAt}) => ChatRoomMessageEntity(
    roomId: 1, senderId: 'buyer', body: 'hi', sentAt: DateTime(2026, 1, 1), selfDestructAt: selfDestructAt);

void main() {
  final now = DateTime(2026, 1, 1, 12);

  group('IsMessageExpired', () {
    test('never expires when selfDestructAt is null (Issue #317)', () {
      expect(IsMessageExpired.call(_msg(), now), isFalse);
    });

    test('is not expired before the timer elapses', () {
      final message = _msg(selfDestructAt: now.add(const Duration(minutes: 1)));
      expect(IsMessageExpired.call(message, now), isFalse);
    });

    test('is expired exactly at the timer', () {
      final message = _msg(selfDestructAt: now);
      expect(IsMessageExpired.call(message, now), isTrue);
    });

    test('is expired after the timer has passed', () {
      final message = _msg(selfDestructAt: now.subtract(const Duration(minutes: 1)));
      expect(IsMessageExpired.call(message, now), isTrue);
    });
  });
}
