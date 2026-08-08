import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_trending_sectors.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final now = DateTime(2026, 2, 1);

  ProcurementRequestEntity request(String sector, DateTime createdAt) => ProcurementRequestEntity(
      requesterId: 'buyer', sector: sector, summary: 's', budgetMin: 0, budgetMax: 0,
      centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
      deadline: createdAt.add(const Duration(days: 1)), createdAt: createdAt);

  test('flags a sector with strong week-over-week growth', () {
    final requests = [
      // previous week: 2 automotive requests
      request('automotive', now.subtract(const Duration(days: 10))),
      request('automotive', now.subtract(const Duration(days: 12))),
      // current week: 5 automotive requests (150% growth)
      for (var i = 0; i < 5; i++) request('automotive', now.subtract(Duration(days: i))),
    ];
    expect(DetectTrendingSectors.call(requests, now), contains('automotive'));
  });

  test('does not flag a sector with flat or declining volume', () {
    final requests = [
      request('real-estate', now.subtract(const Duration(days: 10))),
      request('real-estate', now.subtract(const Duration(days: 12))),
      request('real-estate', now.subtract(const Duration(days: 1))),
    ];
    expect(DetectTrendingSectors.call(requests, now), isEmpty);
  });

  test('flags a brand-new sector with meaningful activity', () {
    final requests = [
      request('landscaping', now.subtract(const Duration(days: 1))),
      request('landscaping', now.subtract(const Duration(days: 2))),
    ];
    expect(DetectTrendingSectors.call(requests, now), contains('landscaping'));
  });
}
