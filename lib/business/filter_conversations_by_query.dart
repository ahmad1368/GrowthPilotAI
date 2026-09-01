import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Case-insensitive subject search for the Inbox screen (Issue #72).
class FilterConversationsByQuery {
  static List<ConversationSummary> call(
      List<ConversationSummary> all, String query) {
    if (query.trim().isEmpty) return all;
    final lower = query.toLowerCase();
    return all.where((c) => c.subject.toLowerCase().contains(lower)).toList();
  }
}
