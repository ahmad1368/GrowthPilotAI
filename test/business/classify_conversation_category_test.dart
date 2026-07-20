import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_conversation_category.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/inbox_category.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

ConversationSummary _summary({double? linkedAmount, ActionCardData? actionCard}) =>
    ConversationSummary(
      conversationId: 1,
      subject: 'Home Depot',
      lastMessagePreview: 'hello',
      lastMessageAt: DateTime(2026, 1, 1),
      unreadCount: 0,
      linkedTransactionAmount: linkedAmount,
      actionCard: actionCard,
    );

const _pendingCard = ActionCardData(
  messageId: 1,
  actionType: ActionCardType.approveTransaction,
  status: ActionCardStatus.pending,
  amount: 450.0,
);

void main() {
  test('a conversation linked to a transaction is FINANCIAL', () {
    final summary = _summary(linkedAmount: 450.0);
    expect(ClassifyConversationCategory.call(summary), InboxCategory.financial);
  });

  test('FINANCIAL takes priority over a pending action card', () {
    final summary = _summary(linkedAmount: 450.0, actionCard: _pendingCard);
    expect(ClassifyConversationCategory.call(summary), InboxCategory.financial);
  });

  test('a conversation with a pending action card (no transaction link) is PENDING', () {
    final summary = _summary(actionCard: _pendingCard);
    expect(ClassifyConversationCategory.call(summary), InboxCategory.pending);
  });

  test('a plain conversation with no context is SUPPORT', () {
    final summary = _summary();
    expect(ClassifyConversationCategory.call(summary), InboxCategory.support);
  });
}
