import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

/// "Room-based Architecture" (Issue #122): isolates a conversation to
/// exactly the two participants, regardless of who initiated it, so a
/// second lookup between the same pair reuses the existing room instead
/// of leaking a duplicate/parallel one.
class FindOrCreateChatRoom {
  static ChatRoomEntity call(
    List<ChatRoomEntity> existingRooms,
    String participantAId,
    String participantBId,
    DateTime now,
  ) {
    for (final room in existingRooms) {
      final isSamePair =
          (room.participantAId == participantAId && room.participantBId == participantBId) ||
              (room.participantAId == participantBId && room.participantBId == participantAId);
      if (isSamePair) return room;
    }
    return ChatRoomEntity(
      participantAId: participantAId,
      participantBId: participantBId,
      createdAt: now,
    );
  }
}
