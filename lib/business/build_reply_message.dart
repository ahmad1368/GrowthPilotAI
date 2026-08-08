import 'package:growth_pilot_ai/business/build_reply_preview.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Builds a threaded reply message pointing at [parent] (Issue #132) —
/// [ChatRoomMessageEntity.replyPreviewText] is denormalized from the
/// parent's body so the UI's "Mini-Preview" never needs a lookup.
class BuildReplyMessage {
  static ChatRoomMessageEntity call({
    required ChatRoomMessageEntity parent,
    required String senderId,
    required String body,
    required DateTime now,
  }) {
    return ChatRoomMessageEntity(
      roomId: parent.roomId,
      senderId: senderId,
      body: body,
      sentAt: now,
      replyToMessageId: parent.id,
      replyPreviewText: BuildReplyPreview.call(parent.body),
    );
  }
}
