import '../../../../objectbox.g.dart';
import '../entities/chat_room_message_entity.dart';

/// Thin ObjectBox wrapper for chat room messages (Issue #122).
class ChatRoomMessageRepository {
  final Box<ChatRoomMessageEntity> _box;

  ChatRoomMessageRepository(this._box);

  int insert(ChatRoomMessageEntity message) => _box.put(message);

  List<ChatRoomMessageEntity> getForRoom(int roomId) {
    final query = _box
        .query(ChatRoomMessageEntity_.roomId.equals(roomId))
        .order(ChatRoomMessageEntity_.sentAt)
        .build();
    final result = query.find();
    query.close();
    return result;
  }
}
