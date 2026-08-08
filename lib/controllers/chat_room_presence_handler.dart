import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';

/// Flips the user-toggled online/typing simulation flags on a
/// [ChatRoomEntity] (Issue #122) — this app has no presence-broadcast
/// gateway, so these stand in for what a real Socket.io server would push.
class ChatRoomPresenceHandler {
  final ChatRoomRepository _rooms;

  ChatRoomPresenceHandler(this._rooms);

  void toggleOnline(ChatRoomEntity room) {
    room.isOtherOnline = !room.isOtherOnline;
    _rooms.upsert(room);
  }

  void toggleTyping(ChatRoomEntity room) {
    room.isOtherTyping = !room.isOtherTyping;
    _rooms.upsert(room);
  }
}
