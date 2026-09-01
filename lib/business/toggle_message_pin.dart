import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// "Pinned Messages in Chats" (Issue #317 feature #22) — flips
/// [ChatRoomMessageEntity.isPinned] while keeping every other field
/// intact, mirroring [BuildEditedMessage]/[BuildDeletedMessage]'s shape.
class ToggleMessagePin {
  static ChatRoomMessageEntity call(ChatRoomMessageEntity original) {
    return ChatRoomMessageEntity(
      id: original.id,
      roomId: original.roomId,
      senderId: original.senderId,
      body: original.body,
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
      isDeleted: original.isDeleted,
      editedAt: original.editedAt,
      isPinned: !original.isPinned,
    );
  }
}
