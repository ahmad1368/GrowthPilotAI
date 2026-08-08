import 'package:growth_pilot_ai/business/find_or_create_chat_room.dart';
import 'package:growth_pilot_ai/controllers/chat_connection_authorizer.dart';
import 'package:growth_pilot_ai/controllers/chat_message_relay_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Authorizes and opens a chat room (Issue #122/#131): finds-or-creates
/// the room, replays history via [ChatMessageRelayHandler], and connects
/// the gateway — refusing to do any of it without a valid session (AC:
/// "Every socket connection must be authenticated").
class ChatRoomJoinHandler {
  final ChatRoomRepository _rooms;
  final ChatConnectionAuthorizer _authorizer;
  final ChatMessageRelayHandler _relay;
  final ChatGatewayService _gateway;
  String? _currentUserId;

  ChatRoomJoinHandler(this._rooms, this._authorizer, this._relay, this._gateway);

  ChatRoomEntity? open(String userId, String otherUserId) {
    if (!_authorizer.isAuthorized()) return null;
    final room = FindOrCreateChatRoom.call(
        _rooms.getAll(), userId, otherUserId, DateTime.now());
    room.id = _rooms.upsert(room);
    _relay.openRoom(room.id);
    _currentUserId = userId;
    _gateway.connect(userId);
    return room;
  }

  void close() {
    if (_currentUserId != null) _gateway.disconnect(_currentUserId!);
  }
}
