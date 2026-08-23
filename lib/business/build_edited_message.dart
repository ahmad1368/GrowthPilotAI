import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/validators/input_sanitizer.dart';

/// "Message Editing (Post-sending with edit history)" (Issue #317
/// feature #18) — sanitizes [newBody] (Issue #167) and stamps
/// [ChatRoomMessageEntity.editedAt], keeping every other field (id,
/// attachment, reply thread) intact. Only the latest body is kept, not
/// a full revision log — see PR notes.
class BuildEditedMessage {
  static ChatRoomMessageEntity call(ChatRoomMessageEntity original, String newBody, DateTime now) {
    return ChatRoomMessageEntity(
      id: original.id,
      roomId: original.roomId,
      senderId: original.senderId,
      body: InputSanitizer.clean(newBody),
      sentAt: original.sentAt,
      readAt: original.readAt,
      replyToMessageId: original.replyToMessageId,
      replyPreviewText: original.replyPreviewText,
      isForwarded: original.isForwarded,
      forwardedFromSenderId: original.forwardedFromSenderId,
      attachmentBytes: original.attachmentBytes,
      attachmentFileName: original.attachmentFileName,
      attachmentFileSize: original.attachmentFileSize,
      attachmentMimeType: original.attachmentMimeType,
      metadataTags: original.metadataTags,
      selfDestructAt: original.selfDestructAt,
      editedAt: now,
    );
  }
}
