import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_chat_payload_size.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  test('emitting a message echoes it on incomingMessages', () async {
    final gateway = MockChatGatewayService();
    final message = ChatRoomMessageEntity(
        roomId: 1, senderId: 'a', body: 'hi', sentAt: DateTime(2026, 1, 1));

    final future = gateway.incomingMessages.first;
    final result = await gateway.emitMessage(message);
    final received = await future;

    expect(result.success, isTrue);
    expect(received.body, 'hi');
  });

  test('rejects a message over the 4KB payload cap', () async {
    final gateway = MockChatGatewayService();
    final oversized = 'a' * (ValidateChatPayloadSize.maxBytes + 1);
    final message = ChatRoomMessageEntity(
        roomId: 1, senderId: 'a', body: oversized, sentAt: DateTime(2026, 1, 1));

    final result = await gateway.emitMessage(message);

    expect(result.success, isFalse);
  });
}
