import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('copyWith replaces only the text, preserving identity fields', () {
      final createdAt = DateTime(2026, 1, 1);
      final message = ChatMessage(id: '1', isFromUser: false, text: 'Hel', createdAt: createdAt);
      final updated = message.copyWith(text: 'Hello');

      expect(updated.id, '1');
      expect(updated.isFromUser, isFalse);
      expect(updated.createdAt, createdAt);
      expect(updated.text, 'Hello');
    });

    test('copyWith records a thumbs-down vote and its reason (Issue #209)', () {
      final message = ChatMessage(id: '1', isFromUser: false, text: 'Hi', createdAt: DateTime(2026, 1, 1));
      final updated =
          message.copyWith(isHelpful: false, feedbackReason: FeedbackReason.inaccurateNumbers);

      expect(updated.isHelpful, isFalse);
      expect(updated.feedbackReason, FeedbackReason.inaccurateNumbers);
    });
  });
}
