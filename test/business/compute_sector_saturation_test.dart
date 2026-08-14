import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_sector_saturation.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(String sector) => ProcurementRequestEntity(
      requesterId: 'buyer', sector: sector, summary: 's', budgetMin: 0, budgetMax: 0,
      centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
      deadline: now.add(const Duration(days: 1)), createdAt: now);

  test('counts and sorts sectors by volume, most active first', () {
    final result = ComputeSectorSaturation.call(
        [request('automotive'), request('automotive'), request('real-estate')]);
    expect(result, [(sector: 'automotive', count: 2), (sector: 'real-estate', count: 1)]);
  });

  test('returns an empty list for no requests', () {
    expect(ComputeSectorSaturation.call([]), isEmpty);
  });
}
