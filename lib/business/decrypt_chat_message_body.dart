import 'package:growth_pilot_ai/core/models/encrypted_chat_message.dart';
import 'package:growth_pilot_ai/core/utils/chat_field_cipher.dart';

/// Reverses [EncryptChatMessageBody] (Issue #317 feature #1).
class DecryptChatMessageBody {
  static Future<String> call(
    EncryptedChatMessage message,
    ChatFieldCipher cipher,
  ) async {
    return cipher.decryptField(message.encryptedBody);
  }
}
