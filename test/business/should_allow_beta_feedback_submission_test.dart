import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_allow_beta_feedback_submission.dart';

void main() {
  group('ShouldAllowBetaFeedbackSubmission', () {
    test('allows submissions under the daily limit (Issue #169 AC)', () {
      expect(ShouldAllowBetaFeedbackSubmission.call(0), isTrue);
      expect(ShouldAllowBetaFeedbackSubmission.call(4), isTrue);
    });

    test('blocks the 6th submission of the day', () {
      expect(ShouldAllowBetaFeedbackSubmission.call(5), isFalse);
      expect(ShouldAllowBetaFeedbackSubmission.call(9), isFalse);
    });
  });
}
