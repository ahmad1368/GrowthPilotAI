import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

/// Rooms [userId] can forward a message into (Issue #132 forward-target
/// picker) — every other room they participate in.
class ListForwardableChatRooms {
  static List<ChatRoomEntity> call(
      List<ChatRoomEntity> allRooms, String userId, int excludeRoomId) {
    return allRooms
        .where((r) =>
            r.id != excludeRoomId &&
            (r.participantAId == userId || r.participantBId == userId))
        .toList();
  }
}
