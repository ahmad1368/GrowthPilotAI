import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for the realtime chat transport (Issue #122). A real backend
/// would be a NestJS Gateway over Socket.io with a Redis pub/sub adapter;
/// this app has no such server, so [MockChatGatewayService] delivers
/// messages in-process instead. Callers stay decoupled from that fact.
abstract class ChatGatewayService {
  void connect(String userId);

  void disconnect(String userId);

  OmniResult<ChatRoomMessageEntity> emitMessage(ChatRoomMessageEntity message);

  Stream<ChatRoomMessageEntity> get incomingMessages;
}
