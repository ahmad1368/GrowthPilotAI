import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_price_trend_line.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final now = DateTime(2026, 1, 30);

  ProcurementRequestEntity request(DateTime createdAt, double min, double max) =>
      ProcurementRequestEntity(
          requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: min, budgetMax: max,
          centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
          deadline: createdAt.add(const Duration(days: 1)), createdAt: createdAt);

  test('averages same-day budgets and orders days chronologically', () {
    final result = ComputePriceTrendLine.call([
      request(DateTime(2026, 1, 29), 100, 100),
      request(DateTime(2026, 1, 28), 50, 50),
      request(DateTime(2026, 1, 28), 150, 150),
    ], 30, now);

    expect(result.map((p) => p.day), [DateTime(2026, 1, 28), DateTime(2026, 1, 29)]);
    expect(result.first.avgBudget, 100);
  });

  test('excludes requests outside the rolling window', () {
    final result = ComputePriceTrendLine.call(
        [request(DateTime(2025, 1, 1), 100, 100)], 30, now);
    expect(result, isEmpty);
  });
}
