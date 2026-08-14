import 'dart:async';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_chat_attachment_message.dart';
import 'package:growth_pilot_ai/business/build_reply_message.dart';
import 'package:growth_pilot_ai/business/extract_message_tags.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

/// Sends/receives messages for one open room (Issue #122) via
/// [ChatGatewayService]. Sending is optimistic (Issue #131 "Optimistic
/// UI" AC): the message shows immediately and is rolled back on
/// failure; [_pending] stops the confirming echo from double-adding it.
class ChatMessageRelayHandler {
  final ChatRoomMessageRepository _messages;
  final ChatGatewayService _gateway;
  final RxList<ChatRoomMessageEntity> inbox;
  /// Set once the room is joined (Issue #124 "Instant Severance").
  bool Function(String senderId)? isSenderBlocked;
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

  Future<bool> send(String senderId, String body) => _dispatch(ChatRoomMessageEntity(
      roomId: roomId, senderId: senderId, body: body, sentAt: DateTime.now()));

  /// Threaded reply (Issue #132) — [parent] must belong to this room.
  Future<bool> sendReply(String senderId, String body, ChatRoomMessageEntity parent) =>
      _dispatch(BuildReplyMessage.call(
          parent: parent, senderId: senderId, body: body, now: DateTime.now()));

  /// Media/document attachment (Issue #133) — false if [mimeType] fails
  /// the allow-list, without dispatching anything.
  Future<bool> sendAttachment(
      String senderId, String fileName, String mimeType, Uint8List bytes) async {
    final message = BuildChatAttachmentMessage.call(
        roomId: roomId, senderId: senderId, fileName: fileName, mimeType: mimeType,
        bytes: bytes, now: DateTime.now());
    if (message == null) return false;
    return _dispatch(message);
  }

  /// Tags the message before it's ever broadcast (Issue #128), matching
  /// the issue's own `handleMessage` ordering (tag, then emit).
  Future<bool> _dispatch(ChatRoomMessageEntity message) async {
    message.metadataTags =
        ExtractMessageTags.call(message.body).map(messageTagDisplayLabel).toList();
    inbox.add(message);
    _pending.add(message);
    final result = await _gateway.emitMessage(message);
    if (!result.success) {
      inbox.remove(message);
      _pending.remove(message);
    }
    return result.success;
  }

  /// "Instant Severance" (Issue #124 AC): messages from a blocked peer
  /// are dropped immediately, never persisted or shown.
  void _onIncoming(ChatRoomMessageEntity message) {
    if (message.roomId != roomId) return;
    if (isSenderBlocked?.call(message.senderId) ?? false) return;
    _messages.insert(message);
    if (_pending.remove(message)) return;
    inbox.add(message);
  }

  void dispose() => _subscription.cancel();
}
