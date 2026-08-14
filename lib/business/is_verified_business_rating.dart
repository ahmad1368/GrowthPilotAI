import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

/// "Verified Transaction Linkage" AC (Issue #125): a rating only counts
/// as Verified if the rater and business have an existing chat room —
/// the local stand-in for the Matching Engine (#145) "confirmed
/// interaction" check this issue defers to, since #145 doesn't exist yet.
class IsVerifiedBusinessRating {
  static bool call(List<ChatRoomEntity> rooms, String raterId, String businessId) {
    return rooms.any((r) =>
        (r.participantAId == raterId && r.participantBId == businessId) ||
        (r.participantAId == businessId && r.participantBId == raterId));
  }
}
