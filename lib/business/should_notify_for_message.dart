import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Whether [ChatNotificationHandler] should push-notify for [message] —
/// never for the sender's own echo, and never for a "Silent Message"
/// (Issue #317 feature #21).
class ShouldNotifyForMessage {
  static bool call(ChatRoomMessageEntity message, String currentUserId) {
    return message.senderId != currentUserId && !message.isSilent;
  }
}
