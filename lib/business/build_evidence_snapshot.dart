import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// "Evidence Snapshotting" (Issue #134): denormalizes the last 10
/// messages of a reported chat into the "Moderation Vault" record.
class BuildEvidenceSnapshot {
  static const maxMessages = 10;

  static String call(List<ChatRoomMessageEntity> messages) {
    final recent =
        messages.length <= maxMessages ? messages : messages.sublist(messages.length - maxMessages);
    return recent.map((m) => '${m.senderId}: ${m.body}').join('\n');
  }
}
