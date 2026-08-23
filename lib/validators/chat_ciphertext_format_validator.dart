import 'dart:convert';

/// Validates a [FieldCipher]-produced `iv:ciphertext` string (Issue #317
/// feature #1) before attempting [DecryptChatMessageBody] — guards
/// against a legacy plaintext or corrupted row crashing the decrypt
/// call once chat encryption is wired into live storage.
class ChatCiphertextFormatValidator {
  static bool isValid(String? value) {
    if (value == null) return false;
    final parts = value.split(':');
    if (parts.length != 2) return false;
    return _isBase64(parts[0]) && _isBase64(parts[1]);
  }

  static bool _isBase64(String part) {
    if (part.isEmpty) return false;
    try {
      base64Decode(part);
      return true;
    } on FormatException {
      return false;
    }
  }
}
