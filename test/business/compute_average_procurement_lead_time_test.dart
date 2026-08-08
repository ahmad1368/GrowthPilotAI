import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_average_procurement_lead_time.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 9);

  ProcurementRequestEntity request(int id) => ProcurementRequestEntity(
      id: id, requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
      centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
      deadline: now.add(const Duration(days: 1)), createdAt: now);

  ProcurementResponseEntity response(int requestId, DateTime createdAt) =>
      ProcurementResponseEntity(requestId: requestId, providerId: 'vendor', message: 'hi', createdAt: createdAt);

  test('averages time to first response across requests', () {
    final requests = [request(1), request(2)];
    final responses = [
      response(1, now.add(const Duration(hours: 1))),
      response(2, now.add(const Duration(hours: 3))),
    ];
    expect(ComputeAverageProcurementLeadTime.call(requests, responses), const Duration(hours: 2));
  });

  test('ignores requests with no responses', () {
    final requests = [request(1), request(2)];
    final responses = [response(1, now.add(const Duration(hours: 2)))];
    expect(ComputeAverageProcurementLeadTime.call(requests, responses), const Duration(hours: 2));
  });

  test('returns zero when nothing has been responded to', () {
    expect(ComputeAverageProcurementLeadTime.call([request(1)], []), Duration.zero);
  });
}
