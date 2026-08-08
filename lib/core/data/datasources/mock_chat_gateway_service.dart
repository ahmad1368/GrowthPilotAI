import 'dart:async';

import 'package:growth_pilot_ai/business/validate_chat_payload_size.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for the NestJS/Socket.io chat gateway (Issue #122).
/// `emitMessage` simulates the server's `handleMessage` handler: reject
/// oversized frames, otherwise echo the message back to every listener
/// (there is no second device to route to in a local-only app).
class MockChatGatewayService implements ChatGatewayService {
  final _controller = StreamController<ChatRoomMessageEntity>.broadcast();

  @override
  void connect(String userId) =>
      OmniLogger.info('Chat gateway: $userId connected');

  @override
  void disconnect(String userId) =>
      OmniLogger.info('Chat gateway: $userId disconnected');

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
