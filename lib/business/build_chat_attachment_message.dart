import 'dart:typed_data';

import 'package:growth_pilot_ai/business/validate_chat_attachment_mime_type.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Builds an attachment message (Issue #133) — returns null if
/// [mimeType] fails the professional-format allow-list (AC: "MIME Type
/// Validation").
class BuildChatAttachmentMessage {
  static ChatRoomMessageEntity? call({
    required int roomId,
    required String senderId,
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
    required DateTime now,
  }) {
    if (!ValidateChatAttachmentMimeType.call(mimeType)) return null;

    return ChatRoomMessageEntity(
      roomId: roomId,
      senderId: senderId,
      body: fileName,
      sentAt: now,
      attachmentBytes: bytes,
      attachmentFileName: fileName,
      attachmentFileSize: bytes.length,
      attachmentMimeType: mimeType,
    );
  }
}
