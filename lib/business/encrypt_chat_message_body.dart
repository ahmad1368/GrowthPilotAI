import 'package:growth_pilot_ai/core/models/encrypted_chat_message.dart';
import 'package:growth_pilot_ai/core/utils/chat_field_cipher.dart';

/// AES-256 encrypts one private chat message's body (Issue #317 feature
/// #1, "E2EE for Private Chats") via [ChatFieldCipher]. Operates on a
/// plain string, not a live [ChatRoomMessageEntity] — see PR notes on
/// why the entity's storage isn't migrated in this PR.
class EncryptChatMessageBody {
  static Future<EncryptedChatMessage> call({
    required String body,
    required ChatFieldCipher cipher,
  }) async {
    return EncryptedChatMessage(encryptedBody: await cipher.encryptField(body));
  }
}
