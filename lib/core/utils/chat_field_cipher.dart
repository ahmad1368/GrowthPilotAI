import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// [FieldCipher] scoped to private chat message bodies (Issue #317
/// feature #1, "E2EE for Private Chats") — its own independent key
/// (`chat_message_encryption_key_v1`) so rotating it never touches the
/// transaction, intelligence-cache, or CRA-log ciphers ([FieldCipher]'s
/// own key-scoping design, from #106/#428).
class ChatFieldCipher extends FieldCipher {
  ChatFieldCipher() : super(keyStorageKey: 'chat_message_encryption_key_v1');
}
