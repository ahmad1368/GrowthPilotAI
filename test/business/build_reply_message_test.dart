import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_reply_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  test('builds a reply pointing at the parent with a denormalized preview', () {
    final parent = ChatRoomMessageEntity(
        id: 7, roomId: 1, senderId: 'vendor', body: 'Is this in stock?', sentAt: DateTime(2026, 1, 1));

    final reply = BuildReplyMessage.call(
        parent: parent, senderId: 'buyer', body: 'Yes, 20 units', now: DateTime(2026, 1, 2));

    expect(reply.roomId, parent.roomId);
    expect(reply.replyToMessageId, 7);
    expect(reply.replyPreviewText, 'Is this in stock?');
    expect(reply.isReply, isTrue);
  });
}
