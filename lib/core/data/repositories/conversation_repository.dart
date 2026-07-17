import '../../../../objectbox.g.dart';
import '../entities/conversation_entity.dart';

/// Thin ObjectBox wrapper for inbox conversations (Issue #70). An entity
/// with id 0 is inserted; ObjectBox assigns the id back onto it in place.
class ConversationRepository {
  final Box<ConversationEntity> _box;

  ConversationRepository(this._box);

  List<ConversationEntity> getAll() => _box.getAll();

  ConversationEntity? findByContext(String contextRefId) {
    final query =
        _box.query(ConversationEntity_.contextRefId.equals(contextRefId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  void upsert(ConversationEntity entity) => _box.put(entity);
}
