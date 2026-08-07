import 'package:growth_pilot_ai/core/data/entities/recommendation_feedback_entity.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_feedback_status.dart';

/// Logs a merchant's accept/dismiss response to a recommendation
/// (Issue #418, acceptance criterion 4) — pure construction, the
/// caller persists it.
class RecordRecommendationFeedback {
  static RecommendationFeedbackEntity call(
      String itemName, RecommendationFeedbackStatus status, DateTime now) {
    return RecommendationFeedbackEntity(
      itemName: itemName,
      dbStatus: status.index,
      recordedAt: now,
    );
  }
}
