import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// Client-side flood/spam guard for outgoing chat messages (Issue #575's
/// "track request velocity per authenticated account... automatically
/// throttle... suspicious traffic", reinterpreted for this local-first
/// app — no NestJS rate-limit gateway/CAPTCHA service exists here to
/// integrate). At most [maxMessagesPerWindow] messages per sender within
/// [window], mirroring [NotificationRateLimiter]'s history-window shape.
class ChatSendRateLimiter {
  static const maxMessagesPerWindow = 5;
  static const window = Duration(seconds: 10);

  static bool allows(List<ChatRoomMessageEntity> roomHistory, String senderId, DateTime now) {
    final cutoff = now.subtract(window);
    final recentBySender =
        roomHistory.where((m) => m.senderId == senderId && m.sentAt.isAfter(cutoff)).length;
    return recentBySender < maxMessagesPerWindow;
  }
}
