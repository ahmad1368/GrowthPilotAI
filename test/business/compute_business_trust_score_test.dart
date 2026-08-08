import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_business_trust_score.dart';
import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  BusinessRatingEntity rating({double score = 5.0, DateTime? createdAt}) => BusinessRatingEntity(
      businessId: 'biz-1',
      raterId: 'buyer',
      punctuality: score,
      accuracy: score,
      communication: score,
      createdAt: createdAt ?? now);

  test('falls back to the global average with no ratings', () {
    expect(ComputeBusinessTrustScore.call(ratings: [], globalAverage: 3.8, now: now), 3.8);
  });

  test('recent perfect ratings pull the score above the global average', () {
    final score = ComputeBusinessTrustScore.call(
        ratings: [rating(), rating(), rating()], globalAverage: 3.8, now: now);
    expect(score, greaterThan(3.8));
    expect(score, lessThan(5.0));
  });

  test('older ratings contribute less due to time decay', () {
    final recentScore = ComputeBusinessTrustScore.call(
        ratings: [rating(createdAt: now)], globalAverage: 3.8, now: now);
    final oldScore = ComputeBusinessTrustScore.call(
        ratings: [rating(createdAt: DateTime(2025, 1, 1))], globalAverage: 3.8, now: now);
    expect(oldScore, lessThan(recentScore));
  });
}
