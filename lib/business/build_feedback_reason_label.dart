import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';

/// Plain-English label for a [FeedbackReason] chip (Issue #209).
class BuildFeedbackReasonLabel {
  static String call(FeedbackReason reason) => switch (reason) {
        FeedbackReason.inaccurateNumbers => 'Inaccurate numbers',
        FeedbackReason.tooVague => 'Too vague',
        FeedbackReason.irrelevantContext => 'Irrelevant context',
      };
}
