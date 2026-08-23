import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/toggle_message_pin.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final sentAt = DateTime(2026, 1, 1, 12);

  ChatRoomMessageEntity message({bool isPinned = false}) => ChatRoomMessageEntity(
        id: 4,
        roomId: 1,
        senderId: 'buyer',
        body: 'let us confirm the price',
        sentAt: sentAt,
        isPinned: isPinned,
      );

  group('ToggleMessagePin', () {
    test('pins an unpinned message (Issue #317 feature #22)', () {
      final toggled = ToggleMessagePin.call(message());
      expect(toggled.isPinned, isTrue);
    });

    test('unpins a pinned message', () {
      final toggled = ToggleMessagePin.call(message(isPinned: true));
      expect(toggled.isPinned, isFalse);
    });

    test('keeps identity and content fields intact', () {
      final toggled = ToggleMessagePin.call(message());

      expect(toggled.id, 4);
      expect(toggled.roomId, 1);
      expect(toggled.senderId, 'buyer');
      expect(toggled.body, 'let us confirm the price');
      expect(toggled.sentAt, sentAt);
    });
  });
}
