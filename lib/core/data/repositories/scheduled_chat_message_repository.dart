import '../../../../objectbox.g.dart';
import '../entities/scheduled_chat_message_entity.dart';

/// ObjectBox wrapper for pending scheduled messages (Issue #317
/// feature #20).
class ScheduledChatMessageRepository {
  final Box<ScheduledChatMessageEntity> _box;

  ScheduledChatMessageRepository(this._box);

  int insert(ScheduledChatMessageEntity message) => _box.put(message);

  List<ScheduledChatMessageEntity> getForRoom(int roomId) {
    final query = _box
        .query(ScheduledChatMessageEntity_.roomId.equals(roomId))
        .order(ScheduledChatMessageEntity_.scheduledFor)
        .build();
    final result = query.find();
    query.close();
    return result;
  }

  void remove(ScheduledChatMessageEntity message) => _box.remove(message.id);
}
