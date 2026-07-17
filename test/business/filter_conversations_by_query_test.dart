import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_conversations_by_query.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

ConversationSummary _summary(String subject) => ConversationSummary(
      conversationId: 1,
      subject: subject,
      lastMessagePreview: '',
      lastMessageAt: DateTime(2026, 1, 1),
      unreadCount: 0,
    );

void main() {
  final all = [_summary('Home Depot'), _summary('BC Hydro')];

  test('an empty query returns everything', () {
    expect(FilterConversationsByQuery.call(all, ''), all);
  });

  test('matches case-insensitively on subject', () {
    final result = FilterConversationsByQuery.call(all, 'home depot');
    expect(result.map((c) => c.subject), ['Home Depot']);
  });

  test('returns an empty list when nothing matches', () {
    expect(FilterConversationsByQuery.call(all, 'xyz'), isEmpty);
  });
}
