import 'package:growth_pilot_ai/core/enum/inbox_category.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// The "Smart Category" engine (Issue #77): FINANCIAL takes priority when a
/// conversation is linked to a transaction (mirrors the issue's own
/// `PlaidTransaction` check ordering), then PENDING for an unresolved
/// ACTION_CARD, else SUPPORT for a plain direct-message thread.
class ClassifyConversationCategory {
  static InboxCategory call(ConversationSummary summary) {
    if (summary.hasLinkedTransaction) return InboxCategory.financial;
    if (summary.actionCard?.isPending ?? false) return InboxCategory.pending;
    return InboxCategory.support;
  }
}
