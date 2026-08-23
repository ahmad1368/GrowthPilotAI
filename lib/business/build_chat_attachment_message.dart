import 'dart:typed_data';

import 'package:growth_pilot_ai/business/validate_chat_attachment_mime_type.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/validators/input_sanitizer.dart';

/// Builds an attachment message (Issue #133) — returns null if
/// [mimeType] fails the professional-format allow-list (AC: "MIME Type
/// Validation"). [fileName] is sanitized (Issue #167 "Input Sanitization")
/// since it is user-controlled and rendered directly as chat bubble text.
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
    final safeFileName = InputSanitizer.clean(fileName);

    return ChatRoomMessageEntity(
      roomId: roomId,
      senderId: senderId,
      body: safeFileName,
      sentAt: now,
      attachmentBytes: bytes,
      attachmentFileName: safeFileName,
      attachmentFileSize: bytes.length,
      attachmentMimeType: mimeType,
    );
  }
}
