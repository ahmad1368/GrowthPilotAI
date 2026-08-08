import 'dart:async';

import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Sends/receives messages for one open room (Issue #122) via
/// [ChatGatewayService]. Sending is optimistic (Issue #131 "Optimistic
/// UI" AC): the message shows immediately and is rolled back on
/// failure; [_pending] stops the confirming echo from double-adding it.
class ChatMessageRelayHandler {
  final ChatRoomMessageRepository _messages;
  final ChatGatewayService _gateway;
  final RxList<ChatRoomMessageEntity> inbox;
  final Set<ChatRoomMessageEntity> _pending = {};
  late final StreamSubscription<ChatRoomMessageEntity> _subscription;
  int roomId = 0;

  ChatMessageRelayHandler(this._messages, this._gateway, this.inbox) {
    _subscription = _gateway.incomingMessages.listen(_onIncoming);
  }

  void openRoom(int id) {
    roomId = id;
    inbox.assignAll(_messages.getForRoom(id));
  }

  Future<bool> send(String senderId, String body) async {
    final message = ChatRoomMessageEntity(
        roomId: roomId, senderId: senderId, body: body, sentAt: DateTime.now());
    inbox.add(message);
    _pending.add(message);
    final result = await _gateway.emitMessage(message);
    if (!result.success) {
      inbox.remove(message);
      _pending.remove(message);
    }
    return result.success;
  }

  void _onIncoming(ChatRoomMessageEntity message) {
    if (message.roomId != roomId) return;
    _messages.insert(message);
    if (_pending.remove(message)) return;
    inbox.add(message);
  }

  void dispose() => _subscription.cancel();
}
