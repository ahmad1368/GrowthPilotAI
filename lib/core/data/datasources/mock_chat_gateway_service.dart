import 'dart:async';

import 'package:growth_pilot_ai/business/validate_chat_payload_size.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/realtime_namespace.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/interfaces/realtime_connection_registry.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Local stand-in for the NestJS/Socket.io chat gateway (Issue #122),
/// registered under the `/chat` namespace of the shared gateway backbone
/// (Issue #130). `emitMessage` simulates the server's `handleMessage`
/// handler: reject oversized frames, otherwise echo the message back to
/// every listener (there is no second device to route to locally).
class MockChatGatewayService implements ChatGatewayService {
  final RealtimeConnectionRegistry _registry;
  final _controller = StreamController<ChatRoomMessageEntity>.broadcast();

  MockChatGatewayService(this._registry);

  @override
  void connect(String userId) =>
      _registry.connect(userId, RealtimeNamespace.chat);

  @override
  void disconnect(String userId) =>
      _registry.disconnect(userId, RealtimeNamespace.chat);

  @override
  OmniResult<ChatRoomMessageEntity> emitMessage(
      ChatRoomMessageEntity message) async {
    if (!ValidateChatPayloadSize.call(message.body)) {
      return OmniResponse.error(
          'Message exceeds ${ValidateChatPayloadSize.maxBytes} byte limit.');
    }
    _controller.add(message);
    return OmniResponse.success(message);
  }

  @override
  Stream<ChatRoomMessageEntity> get incomingMessages => _controller.stream;
}
