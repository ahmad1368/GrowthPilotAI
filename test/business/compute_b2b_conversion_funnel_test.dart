import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_b2b_conversion_funnel.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(int id, {ProcurementRequestStatus status = ProcurementRequestStatus.open}) =>
      ProcurementRequestEntity(
          id: id, requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
          centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
          deadline: now.add(const Duration(days: 1)), createdAt: now)
        ..status = status;

  test('counts broadcast, negotiating, and matched stages', () {
    final requests = [
      request(1),
      request(2, status: ProcurementRequestStatus.accepted),
      request(3),
    ];
    final responses = [
      ProcurementResponseEntity(requestId: 1, providerId: 'v', message: 'hi', createdAt: now),
      ProcurementResponseEntity(requestId: 2, providerId: 'v', message: 'hi', createdAt: now),
    ];

    final funnel = ComputeB2BConversionFunnel.call(requests, responses);

    expect(funnel.broadcast, 3);
    expect(funnel.negotiating, 2);
    expect(funnel.matched, 1);
  });
}
