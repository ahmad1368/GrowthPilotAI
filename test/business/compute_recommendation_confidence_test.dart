import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_recommendation_confidence.dart';
import 'package:growth_pilot_ai/core/data/entities/recommendation_feedback_entity.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_feedback_status.dart';

RecommendationFeedbackEntity _feedback(RecommendationFeedbackStatus status) {
  return RecommendationFeedbackEntity(
    itemName: 'Espresso Beans',
    dbStatus: status.index,
    recordedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('no history defaults to a neutral 50%', () {
    expect(ComputeRecommendationConfidence.call([]), 0.5);
  });

  test('computes the accept rate across history', () {
    final history = [
      _feedback(RecommendationFeedbackStatus.accepted),
      _feedback(RecommendationFeedbackStatus.accepted),
      _feedback(RecommendationFeedbackStatus.dismissed),
      _feedback(RecommendationFeedbackStatus.dismissed),
    ];
    expect(ComputeRecommendationConfidence.call(history), 0.5);
  });

  test('all accepted scores 100%', () {
    final history = [
      _feedback(RecommendationFeedbackStatus.accepted),
      _feedback(RecommendationFeedbackStatus.accepted),
    ];
    expect(ComputeRecommendationConfidence.call(history), 1.0);
  });
}
