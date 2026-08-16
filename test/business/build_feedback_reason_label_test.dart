import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_feedback_reason_label.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';

void main() {
  group('BuildFeedbackReasonLabel', () {
    test('produces a plain-English label for every reason', () {
      expect(BuildFeedbackReasonLabel.call(FeedbackReason.inaccurateNumbers), 'Inaccurate numbers');
      expect(BuildFeedbackReasonLabel.call(FeedbackReason.tooVague), 'Too vague');
      expect(BuildFeedbackReasonLabel.call(FeedbackReason.irrelevantContext), 'Irrelevant context');
    });
  });
}
