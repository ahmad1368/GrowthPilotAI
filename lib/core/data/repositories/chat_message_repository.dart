import '../../../../objectbox.g.dart';
import '../entities/chat_message_entity.dart';

/// Insert/lookup CRUD for cross-language chat messages (Issue #430).
class ChatMessageRepository {
  final Box<ChatMessageEntity> _box;

  ChatMessageRepository(this._box);

  int save(ChatMessageEntity message) => _box.put(message);

  List<ChatMessageEntity> getAll() => _box.getAll()..sort((a, b) => a.sentAt.compareTo(b.sentAt));
}
