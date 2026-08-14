import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/expire_overdue_procurement_requests.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

void main() {
  final now = DateTime(2026, 1, 10);

  ProcurementRequestEntity request(DateTime deadline, {ProcurementRequestStatus status = ProcurementRequestStatus.open}) =>
      ProcurementRequestEntity(
        requesterId: 'buyer',
        sector: 'automotive',
        summary: 'Need brake repair',
        budgetMin: 100,
        budgetMax: 200,
        centerLat: 49.19,
        centerLng: -122.85,
        radiusKm: 10,
        neighborhood: 'Whalley',
        deadline: deadline,
        createdAt: now,
      )..status = status;

  test('expires open requests past their deadline', () {
    final overdue = request(DateTime(2026, 1, 1));
    final changed = ExpireOverdueProcurementRequests.call([overdue], now);
    expect(changed, [overdue]);
    expect(overdue.status, ProcurementRequestStatus.expired);
  });

  test('leaves requests with a future deadline untouched', () {
    final future = request(DateTime(2026, 2, 1));
    final changed = ExpireOverdueProcurementRequests.call([future], now);
    expect(changed, isEmpty);
    expect(future.status, ProcurementRequestStatus.open);
  });

  test('does not re-expire an already-accepted request', () {
    final accepted = request(DateTime(2026, 1, 1), status: ProcurementRequestStatus.accepted);
    final changed = ExpireOverdueProcurementRequests.call([accepted], now);
    expect(changed, isEmpty);
  });
}
