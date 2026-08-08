import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/forecast_weekly_b2b_demand.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final week0 = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(DateTime createdAt) => ProcurementRequestEntity(
      requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
      centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
      deadline: createdAt.add(const Duration(days: 1)), createdAt: createdAt);

  test('returns zero for no historical data', () {
    expect(ForecastWeeklyB2BDemand.call([]), 0.0);
  });

  test('extrapolates a rising weekly trend', () {
    final requests = [
      request(week0), // week 0: 1
      request(week0.add(const Duration(days: 7))), // week 1: 2
      request(week0.add(const Duration(days: 7))),
      request(week0.add(const Duration(days: 14))), // week 2: 3
      request(week0.add(const Duration(days: 14))),
      request(week0.add(const Duration(days: 14))),
    ];
    expect(ForecastWeeklyB2BDemand.call(requests), greaterThan(3));
  });
}
