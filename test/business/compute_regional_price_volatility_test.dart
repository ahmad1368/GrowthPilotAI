import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_regional_price_volatility.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(String neighborhood, double min, double max) =>
      ProcurementRequestEntity(
          requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: min, budgetMax: max,
          centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: neighborhood,
          deadline: now.add(const Duration(days: 1)), createdAt: now);

  test('zero std dev when every budget midpoint is identical', () {
    final result = ComputeRegionalPriceVolatility.call(
        [request('Whalley', 100, 100), request('Whalley', 100, 100)]);
    expect(result.single.stdDev, 0.0);
  });

  test('a single request has no measurable volatility', () {
    final result = ComputeRegionalPriceVolatility.call([request('Whalley', 100, 200)]);
    expect(result.single.stdDev, 0.0);
  });

  test('reports non-zero volatility for inconsistent budgets in the same area', () {
    final result = ComputeRegionalPriceVolatility.call(
        [request('Whalley', 50, 50), request('Whalley', 500, 500)]);
    expect(result.single.stdDev, greaterThan(0));
  });
}
