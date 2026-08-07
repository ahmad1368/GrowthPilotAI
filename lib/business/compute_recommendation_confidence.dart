import 'package:growth_pilot_ai/core/data/entities/recommendation_feedback_entity.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_feedback_status.dart';

/// Approximates "continuous model retraining" (Issue #418, acceptance
/// criterion 4) as an accept-rate heuristic over this item's past
/// feedback — this app has no real ML pipeline, so confidence is a
/// simple historical ratio rather than a retrained model's output. No
/// history yet defaults to a neutral 50%.
class ComputeRecommendationConfidence {
  static double call(List<RecommendationFeedbackEntity> itemFeedback) {
    if (itemFeedback.isEmpty) return 0.5;
    final accepted =
        itemFeedback.where((f) => f.status == RecommendationFeedbackStatus.accepted).length;
    return accepted / itemFeedback.length;
  }
}
