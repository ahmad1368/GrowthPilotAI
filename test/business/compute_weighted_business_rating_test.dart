import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_weighted_business_rating.dart';

void main() {
  test('a single perfect review does not outrank an established track record', () {
    final established = ComputeWeightedBusinessRating.call(
        reviewCount: 100, averageRating: 4.5, globalAverage: 3.8);
    final newcomer = ComputeWeightedBusinessRating.call(
        reviewCount: 1, averageRating: 5.0, globalAverage: 3.8);

    expect(established, greaterThan(newcomer));
  });

  test('falls back to the global average with zero reviews', () {
    expect(
        ComputeWeightedBusinessRating.call(reviewCount: 0, averageRating: 0, globalAverage: 3.8),
        3.8);
  });

  test('converges toward the raw average as review count grows', () {
    final huge = ComputeWeightedBusinessRating.call(
        reviewCount: 100000, averageRating: 4.5, globalAverage: 3.8);
    expect(huge, closeTo(4.5, 0.01));
  });
}
