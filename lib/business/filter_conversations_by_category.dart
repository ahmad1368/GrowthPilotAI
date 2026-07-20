import 'package:growth_pilot_ai/business/classify_conversation_category.dart';
import 'package:growth_pilot_ai/core/enum/inbox_category.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Filter-bar tab logic for the Inbox (Issue #77): [InboxCategory.all]
/// passes everything through; any other category keeps only the
/// conversations [ClassifyConversationCategory] assigns to it.
class FilterConversationsByCategory {
  static List<ConversationSummary> call(
      List<ConversationSummary> all, InboxCategory category) {
    if (category == InboxCategory.all) return all;
    return all
        .where((c) => ClassifyConversationCategory.call(c) == category)
        .toList();
  }
}
