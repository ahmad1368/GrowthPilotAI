import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/chat_send_rate_limiter.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

ChatRoomMessageEntity _msg(String senderId, DateTime sentAt) =>
    ChatRoomMessageEntity(roomId: 1, senderId: senderId, body: 'hi', sentAt: sentAt);

void main() {
  final now = DateTime(2026, 1, 1, 12, 0, 10);

  group('ChatSendRateLimiter', () {
    test('allows a sender under the window limit (Issue #575)', () {
      final history = List.generate(4, (i) => _msg('buyer', now.subtract(Duration(seconds: i))));
      expect(ChatSendRateLimiter.allows(history, 'buyer', now), isTrue);
    });

    test('blocks a sender who hit the limit within the window', () {
      final history = List.generate(5, (i) => _msg('buyer', now.subtract(Duration(seconds: i))));
      expect(ChatSendRateLimiter.allows(history, 'buyer', now), isFalse);
    });

    test('ignores messages outside the window', () {
      final history = List.generate(5, (_) => _msg('buyer', now.subtract(const Duration(minutes: 5))));
      expect(ChatSendRateLimiter.allows(history, 'buyer', now), isTrue);
    });

    test('tracks each sender independently', () {
      final history = List.generate(5, (i) => _msg('buyer', now.subtract(Duration(seconds: i))));
      expect(ChatSendRateLimiter.allows(history, 'vendor', now), isTrue);
    });
  });
}
