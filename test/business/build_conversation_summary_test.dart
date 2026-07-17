import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_conversation_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_context_type.dart';

ConversationEntity _conversation({bool linked = false}) => ConversationEntity(
      id: 1,
      subject: 'Home Depot',
      participantIds: const ['me', 'vendor'],
      lastMessageAt: DateTime(2026, 1, 1),
      dbContextType:
          linked ? ConversationContextType.transaction.index : 0,
      contextRefId: linked ? 'plaid-hd-451' : null,
    );

void main() {
  test('picks the most recent message as the preview', () {
    final messages = [
      MessageEntity(
          conversationId: 1,
          senderId: 'a',
          body: 'first',
          createdAt: DateTime(2026, 1, 1)),
      MessageEntity(
          conversationId: 1,
          senderId: 'a',
          body: 'latest',
          createdAt: DateTime(2026, 1, 2)),
    ];

    final summary = BuildConversationSummary.call(_conversation(), messages, null);

    expect(summary.lastMessagePreview, 'latest');
    expect(summary.lastMessageAt, DateTime(2026, 1, 2));
  });

  test('counts only unread messages', () {
    final messages = [
      MessageEntity(
          conversationId: 1,
          senderId: 'a',
          body: 'a',
          isRead: true,
          createdAt: DateTime(2026, 1, 1)),
      MessageEntity(
          conversationId: 1,
          senderId: 'a',
          body: 'b',
          createdAt: DateTime(2026, 1, 2)),
    ];

    final summary = BuildConversationSummary.call(_conversation(), messages, null);

    expect(summary.unreadCount, 1);
  });

  test('surfaces the linked transaction amount only when contextual', () {
    final linked =
        BuildConversationSummary.call(_conversation(linked: true), [], 450.0);
    final unlinked = BuildConversationSummary.call(_conversation(), [], 450.0);

    expect(linked.linkedTransactionAmount, 450.0);
    expect(unlinked.linkedTransactionAmount, isNull);
  });

  test('falls back to a placeholder preview with no messages', () {
    final summary = BuildConversationSummary.call(_conversation(), [], null);
    expect(summary.lastMessagePreview, 'No messages yet');
  });
}
