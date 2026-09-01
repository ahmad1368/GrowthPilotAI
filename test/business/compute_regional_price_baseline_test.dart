import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_regional_price_baseline.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';

void main() {
  test('averages competitor prices for matching product names, case-insensitively', () {
    final observations = [
      CompetitorPriceObservationEntity(
          id: 1,
          productName: 'Espresso Beans',
          competitorName: 'A',
          ourPrice: 10,
          competitorPrice: 12,
          observedAt: DateTime(2026, 1, 1)),
      CompetitorPriceObservationEntity(
          id: 2,
          productName: 'espresso beans',
          competitorName: 'B',
          ourPrice: 10,
          competitorPrice: 14,
          observedAt: DateTime(2026, 1, 15)),
      CompetitorPriceObservationEntity(
          id: 3,
          productName: 'Bar Stools',
          competitorName: 'C',
          ourPrice: 40,
          competitorPrice: 45,
          observedAt: DateTime(2026, 1, 20)),
    ];

    final result = ComputeRegionalPriceBaseline.call('Espresso Beans', observations);

    expect(result.sampleCount, 2);
    expect(result.averagePrice, closeTo(13.0, 0.001));
  });

  test('an unmatched product returns a zero baseline with no samples', () {
    final result = ComputeRegionalPriceBaseline.call('Unknown Item', []);
    expect(result.sampleCount, 0);
    expect(result.averagePrice, 0);
  });
}
