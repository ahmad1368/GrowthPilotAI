import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_deleted_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  ChatRoomMessageEntity original() => ChatRoomMessageEntity(
        id: 7,
        roomId: 1,
        senderId: 'buyer',
        body: 'sensitive negotiation detail',
        sentAt: now,
        replyToMessageId: 3,
        replyPreviewText: 'earlier message',
        attachmentBytes: Uint8List.fromList([1, 2, 3]),
        attachmentFileName: 'invoice.pdf',
        attachmentFileSize: 3,
        attachmentMimeType: 'application/pdf',
        metadataTags: const ['#PriceNegotiation'],
      );

  group('BuildDeletedMessage', () {
    test('wipes body and attachment content without a trace (Issue #317 feature #19)', () {
      final deleted = BuildDeletedMessage.call(original());

      expect(deleted.isDeleted, isTrue);
      expect(deleted.body, isEmpty);
      expect(deleted.hasAttachment, isFalse);
      expect(deleted.attachmentFileName, isNull);
      expect(deleted.metadataTags, isEmpty);
    });

    test('keeps identity and thread fields intact for reply consistency', () {
      final deleted = BuildDeletedMessage.call(original());

      expect(deleted.id, 7);
      expect(deleted.roomId, 1);
      expect(deleted.senderId, 'buyer');
      expect(deleted.sentAt, now);
      expect(deleted.replyToMessageId, 3);
      expect(deleted.replyPreviewText, 'earlier message');
    });
  });
}
