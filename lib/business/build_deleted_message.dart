import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// "Unsending / Deleting for Everyone Without Trace" (Issue #317
/// feature #19) — wipes [body]/attachment/tag content in place while
/// keeping id/roomId/senderId/sentAt/reply-thread fields intact, so
/// deletion propagates as an upsert peers can apply by matching id
/// rather than needing a separate delete event on the wire.
class BuildDeletedMessage {
  static ChatRoomMessageEntity call(ChatRoomMessageEntity original) {
    return ChatRoomMessageEntity(
      id: original.id,
      roomId: original.roomId,
      senderId: original.senderId,
      body: '',
      sentAt: original.sentAt,
      readAt: original.readAt,
      replyToMessageId: original.replyToMessageId,
      replyPreviewText: original.replyPreviewText,
      isForwarded: original.isForwarded,
      forwardedFromSenderId: original.forwardedFromSenderId,
      selfDestructAt: original.selfDestructAt,
      isDeleted: true,
    );
  }
}
