import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_clear_chat_session.dart';

void main() {
  group('ShouldClearChatSession', () {
    final lastActivityAt = DateTime(2026, 1, 1, 12);

    test('false immediately after activity', () {
      expect(ShouldClearChatSession.call(lastActivityAt, lastActivityAt), isFalse);
    });

    test('false just under the 10-minute threshold', () {
      final now = lastActivityAt.add(const Duration(minutes: 9, seconds: 59));
      expect(ShouldClearChatSession.call(lastActivityAt, now), isFalse);
    });

    test('true at exactly 10 minutes and beyond', () {
      final now = lastActivityAt.add(const Duration(minutes: 10));
      expect(ShouldClearChatSession.call(lastActivityAt, now), isTrue);
    });

    test('false when there has been no activity yet', () {
      expect(ShouldClearChatSession.call(null, DateTime.now()), isFalse);
    });
  });
}
