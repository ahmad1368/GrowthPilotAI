import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_price_trend_points.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';

void main() {
  test('sorts matching observations chronologically and maps to trend points', () {
    final observations = [
      CompetitorPriceObservationEntity(
          id: 1,
          productName: 'Espresso Beans',
          competitorName: 'A',
          ourPrice: 10,
          competitorPrice: 14,
          observedAt: DateTime(2026, 2, 1)),
      CompetitorPriceObservationEntity(
          id: 2,
          productName: 'Espresso Beans',
          competitorName: 'B',
          ourPrice: 10,
          competitorPrice: 12,
          observedAt: DateTime(2026, 1, 1)),
      CompetitorPriceObservationEntity(
          id: 3,
          productName: 'Bar Stools',
          competitorName: 'C',
          ourPrice: 40,
          competitorPrice: 45,
          observedAt: DateTime(2026, 1, 15)),
    ];

    final points = BuildPriceTrendPoints.call('Espresso Beans', observations);

    expect(points.length, 2);
    expect(points[0].observedAt, DateTime(2026, 1, 1));
    expect(points[0].price, 12);
    expect(points[1].observedAt, DateTime(2026, 2, 1));
    expect(points[1].price, 14);
  });
}
