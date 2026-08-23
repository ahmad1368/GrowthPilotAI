import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_edited_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final sentAt = DateTime(2026, 1, 1, 12);
  final editedAt = DateTime(2026, 1, 1, 12, 5);

  ChatRoomMessageEntity original() => ChatRoomMessageEntity(
        id: 9,
        roomId: 1,
        senderId: 'buyer',
        body: 'origional typo',
        sentAt: sentAt,
        replyToMessageId: 3,
        metadataTags: const ['#PriceNegotiation'],
      );

  group('BuildEditedMessage', () {
    test('updates body and stamps editedAt (Issue #317 feature #18)', () {
      final edited = BuildEditedMessage.call(original(), 'corrected text', editedAt);

      expect(edited.body, 'corrected text');
      expect(edited.editedAt, editedAt);
      expect(edited.isEdited, isTrue);
    });

    test('sanitizes the new body against script injection (Issue #167)', () {
      final edited = BuildEditedMessage.call(original(), '<script>alert(1)</script>hi', editedAt);
      expect(edited.body, isNot(contains('<script>')));
    });

    test('keeps identity and thread fields intact', () {
      final edited = BuildEditedMessage.call(original(), 'new text', editedAt);

      expect(edited.id, 9);
      expect(edited.roomId, 1);
      expect(edited.senderId, 'buyer');
      expect(edited.sentAt, sentAt);
      expect(edited.replyToMessageId, 3);
      expect(edited.metadataTags, ['#PriceNegotiation']);
    });
  });
}
