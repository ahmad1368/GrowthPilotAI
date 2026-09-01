import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';

/// Applies one incoming message to [inbox] (Issue #122) — persists it,
/// then either resolves the sender's own optimistic pending entry
/// (Issue #131) or upserts by id (Issue #317 feature #19, so a
/// "Delete for Everyone" echo replaces the original instead of
/// duplicating it).
class HandleIncomingChatMessage {
  static void call({
    required ChatRoomMessageRepository repo,
    required RxList<ChatRoomMessageEntity> inbox,
    required Set<ChatRoomMessageEntity> pending,
    required ChatRoomMessageEntity message,
  }) {
    repo.insert(message);
    if (pending.remove(message)) return;
    final index = inbox.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      inbox[index] = message;
    } else {
      inbox.add(message);
    }
  }
}
