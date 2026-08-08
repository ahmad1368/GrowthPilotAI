import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/enforce_minimum_sample_size.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(String requesterId) => ProcurementRequestEntity(
      requesterId: requesterId, sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
      centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
      deadline: now.add(const Duration(days: 1)), createdAt: now);

  test('passes with 5 or more distinct businesses', () {
    final requests = List.generate(5, (i) => request('buyer-$i'));
    expect(EnforceMinimumSampleSize.call(requests), isTrue);
  });

  test('fails with fewer than 5 distinct businesses, even with many requests', () {
    final requests = List.generate(10, (_) => request('buyer-1'));
    expect(EnforceMinimumSampleSize.call(requests), isFalse);
  });
}
