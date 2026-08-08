import '../../../../objectbox.g.dart';
import '../entities/chat_room_entity.dart';

/// Thin ObjectBox wrapper for chat rooms (Issue #122), mirroring
/// [ConversationRepository]'s insert/getAll pattern.
class ChatRoomRepository {
  final Box<ChatRoomEntity> _box;

  ChatRoomRepository(this._box);

  List<ChatRoomEntity> getAll() => _box.getAll();

  int upsert(ChatRoomEntity room) => _box.put(room);
}
