import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_trust_score.dart';

void main() {
  test('a perfect profile with no strikes scores near the top', () {
    final score = ComputeTrustScore.call(
      bayesianRating: 5,
      responseVelocityScore: 1,
      completionScore: 1,
      longevityScore: 1,
      activeStrikeCount: 0,
    );
    expect(score, 10.0);
  });

  test('active strikes subtract flat penalty points', () {
    final clean = ComputeTrustScore.call(
        bayesianRating: 5, responseVelocityScore: 1, completionScore: 1, longevityScore: 1, activeStrikeCount: 0);
    final struck = ComputeTrustScore.call(
        bayesianRating: 5, responseVelocityScore: 1, completionScore: 1, longevityScore: 1, activeStrikeCount: 2);
    expect(clean - struck, 3.0);
  });

  test('never goes below zero even with many strikes', () {
    final score = ComputeTrustScore.call(
        bayesianRating: 0, responseVelocityScore: 0, completionScore: 0, longevityScore: 0, activeStrikeCount: 20);
    expect(score, 0.0);
  });

  test('reviews (50% weight) outweigh a single 20%-weighted factor', () {
    final reviewsOnly = ComputeTrustScore.call(
        bayesianRating: 5, responseVelocityScore: 0, completionScore: 0, longevityScore: 0, activeStrikeCount: 0);
    final responseOnly = ComputeTrustScore.call(
        bayesianRating: 0, responseVelocityScore: 1, completionScore: 0, longevityScore: 0, activeStrikeCount: 0);
    expect(reviewsOnly, greaterThan(responseOnly));
  });
}
