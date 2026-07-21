import '../../../../objectbox.g.dart';
import '../entities/message_entity.dart';

/// Thin ObjectBox wrapper for inbox messages (Issue #70), scoped by
/// [MessageEntity.conversationId].
class MessageRepository {
  final Box<MessageEntity> _box;

  MessageRepository(this._box);

  List<MessageEntity> getForConversation(int conversationId) {
    final query = _box
        .query(MessageEntity_.conversationId.equals(conversationId))
        .order(MessageEntity_.createdAt)
        .build();
    final result = query.find();
    query.close();
    return result;
  }

  void upsert(MessageEntity entity) => _box.put(entity);

  void upsertAll(List<MessageEntity> entities) => _box.putMany(entities);
}
