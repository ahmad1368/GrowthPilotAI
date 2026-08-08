import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// "Response Velocity" weight input (Issue #135) — average time from a
/// customer's message to the business's next reply in the same room,
/// scored 1.0 (instant) down to 0.0 (24h+, no response).
class ComputeResponseVelocityScore {
  static const noResponseThreshold = Duration(hours: 24);

  static double call(List<ChatRoomMessageEntity> messages, String businessId) {
    final byRoom = <int, List<ChatRoomMessageEntity>>{};
    for (final m in messages) {
      byRoom.putIfAbsent(m.roomId, () => []).add(m);
    }

    final gapsInMinutes = <int>[];
    for (final roomMessages in byRoom.values) {
      final sorted = [...roomMessages]..sort((a, b) => a.sentAt.compareTo(b.sentAt));
      for (var i = 0; i < sorted.length; i++) {
        if (sorted[i].senderId == businessId) continue;
        final reply = sorted.skip(i + 1).firstWhere(
            (m) => m.senderId == businessId,
            orElse: () => sorted[i]);
        if (!identical(reply, sorted[i])) {
          gapsInMinutes.add(reply.sentAt.difference(sorted[i].sentAt).inMinutes);
        }
      }
    }

    if (gapsInMinutes.isEmpty) return 0.5; // no data yet — neutral score
    final avgMinutes = gapsInMinutes.reduce((a, b) => a + b) / gapsInMinutes.length;
    return (1 - (avgMinutes / noResponseThreshold.inMinutes)).clamp(0.0, 1.0);
  }
}
