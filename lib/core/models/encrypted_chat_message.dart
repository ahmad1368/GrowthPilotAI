import 'package:flutter/foundation.dart';

/// AES-256 ciphertext for one [ChatRoomMessageEntity.body] (Issue #317
/// feature #1). [encryptedBody] is `iv:ciphertext`, base64-encoded, per
/// [FieldCipher]'s format.
@immutable
class EncryptedChatMessage {
  final String encryptedBody;

  const EncryptedChatMessage({required this.encryptedBody});
}
