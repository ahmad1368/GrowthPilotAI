import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_conversations_by_category.dart';
import 'package:growth_pilot_ai/core/enum/inbox_category.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

ConversationSummary _summary(int id, {double? linkedAmount}) => ConversationSummary(
      conversationId: id,
      subject: 'thread $id',
      lastMessagePreview: 'hello',
      lastMessageAt: DateTime(2026, 1, 1),
      unreadCount: 0,
      linkedTransactionAmount: linkedAmount,
    );

void main() {
  final all = [
    _summary(1, linkedAmount: 450.0),
    _summary(2),
    _summary(3),
  ];

  test('InboxCategory.all returns every conversation unchanged', () {
    expect(FilterConversationsByCategory.call(all, InboxCategory.all), all);
  });

  test('InboxCategory.financial keeps only transaction-linked conversations', () {
    final result = FilterConversationsByCategory.call(all, InboxCategory.financial);
    expect(result.map((c) => c.conversationId), [1]);
  });

  test('InboxCategory.support keeps only conversations with no context', () {
    final result = FilterConversationsByCategory.call(all, InboxCategory.support);
    expect(result.map((c) => c.conversationId), [2, 3]);
  });
}
