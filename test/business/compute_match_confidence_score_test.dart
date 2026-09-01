import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_match_confidence_score.dart';

void main() {
  test('a perfect match on every dimension scores 1.0', () {
    final score = ComputeMatchConfidenceScore.call(
        semanticSimilarity: 1, geoProximityScore: 1, reputationScore: 1, availabilityScore: 1);
    expect(score, 1.0);
  });

  test('weights semantic similarity most heavily (40%)', () {
    final semanticOnly = ComputeMatchConfidenceScore.call(
        semanticSimilarity: 1, geoProximityScore: 0, reputationScore: 0, availabilityScore: 0);
    final geoOnly = ComputeMatchConfidenceScore.call(
        semanticSimilarity: 0, geoProximityScore: 1, reputationScore: 0, availabilityScore: 0);
    expect(semanticOnly, greaterThan(geoOnly));
    expect(semanticOnly, 0.4);
    expect(geoOnly, 0.3);
  });

  test('a score above the notification threshold requires strong signals across the board', () {
    final score = ComputeMatchConfidenceScore.call(
        semanticSimilarity: 0.9, geoProximityScore: 0.9, reputationScore: 0.8, availabilityScore: 1);
    expect(score, greaterThan(ComputeMatchConfidenceScore.notificationThreshold));
  });
}
