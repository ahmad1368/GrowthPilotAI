import 'package:growth_pilot_ai/business/build_conversation_summary.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Loads every conversation as a most-recent-first [ConversationSummary]
/// list (Issue #72), resolving each row's linked-transaction amount (Issue
/// #69) and ACTION_CARD payload (Issue #73).
class LoadInboxSummaries {
  static List<ConversationSummary> call(
    ConversationRepository conversations,
    MessageRepository messages,
    UnifiedTransactionRepository transactions,
  ) {
    final txAmountByExternalId = {
      for (final tx in transactions.getAll()) tx.externalId: tx.amount,
    };
    return conversations.getAll().map((conversation) {
      final msgs = messages.getForConversation(conversation.id);
      final amount = conversation.contextRefId == null
          ? null
          : txAmountByExternalId[conversation.contextRefId];
      return BuildConversationSummary.call(conversation, msgs, amount);
    }).toList()
      ..sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
  }
}
