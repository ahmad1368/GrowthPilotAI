import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Secret Chat self-destruct check (Issue #317 feature #2) — a message
/// with no [ChatRoomMessageEntity.selfDestructAt] never expires.
class IsMessageExpired {
  static bool call(ChatRoomMessageEntity message, DateTime now) {
    final at = message.selfDestructAt;
    return at != null && !now.isBefore(at);
  }
}
