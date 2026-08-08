import 'package:growth_pilot_ai/business/forward_chat_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';

/// Forwards a message into a different, already-existing room (Issue
/// #132) — a direct persistence write, not routed through the live
/// gateway relay, since the target room may not be the one currently
/// open in this session.
class ChatForwardHandler {
  final ChatRoomRepository _rooms;
  final ChatRoomMessageRepository _messages;

  ChatForwardHandler(this._rooms, this._messages);

  /// Returns false if [forwarderId] isn't a participant of [targetRoomId].
  bool forward(ChatRoomMessageEntity original, int targetRoomId, String forwarderId) {
    final targetRoom = _rooms.getAll().where((r) => r.id == targetRoomId).firstOrNull;
    if (targetRoom == null) return false;
    final forwarded = ForwardChatMessage.call(
        original: original, targetRoom: targetRoom, forwarderId: forwarderId, now: DateTime.now());
    if (forwarded == null) return false;
    _messages.insert(forwarded);
    return true;
  }
}
