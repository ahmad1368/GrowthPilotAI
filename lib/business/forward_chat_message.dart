import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Clones [original] into [targetRoom] as a labeled "Forwarded" message
/// (Issue #132) — returns null if [forwarderId] isn't one of the target
/// room's two participants (AC: "Privacy Integrity" / permission guard).
class ForwardChatMessage {
  static ChatRoomMessageEntity? call({
    required ChatRoomMessageEntity original,
    required ChatRoomEntity targetRoom,
    required String forwarderId,
    required DateTime now,
  }) {
    final isParticipant = targetRoom.participantAId == forwarderId ||
        targetRoom.participantBId == forwarderId;
    if (!isParticipant) return null;

    return ChatRoomMessageEntity(
      roomId: targetRoom.id,
      senderId: forwarderId,
      body: original.body,
      sentAt: now,
      isForwarded: true,
      forwardedFromSenderId: original.senderId,
    );
  }
}
