import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

void main() {
  test('ConversationEntity defaults to active status with no context', () {
    final conversation = ConversationEntity(
      subject: 'Test thread',
      participantIds: const ['me', 'them'],
      lastMessageAt: DateTime(2026, 1, 1),
    );

    expect(conversation.status, ConversationStatus.active);
    expect(conversation.hasContext, isFalse);
  });

  test('MessageEntity defaults to unread plain text with no attachment', () {
    final message = MessageEntity(
      conversationId: 1,
      senderId: 'them',
      body: 'hello',
      createdAt: DateTime(2026, 1, 1),
    );

    expect(message.contentType, MessageContentType.text);
    expect(message.isRead, isFalse);
    expect(message.hasAttachment, isFalse);
  });
}
