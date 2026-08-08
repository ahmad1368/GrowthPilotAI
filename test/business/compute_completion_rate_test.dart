import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_completion_rate.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(int id, ProcurementRequestStatus status) =>
      ProcurementRequestEntity(
          id: id, requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
          centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
          deadline: now.add(const Duration(days: 1)), createdAt: now)
        ..status = status;

  PaymentEntity payment(int requestId, PaymentIntentStatus status) => PaymentEntity(
      invoiceId: 1, requestId: requestId, buyerId: 'buyer', sellerId: 'vendor', amount: 100,
      createdAt: now)
    ..status = status;

  test('returns a neutral default with no accepted requests', () {
    expect(ComputeCompletionRate.call([], []), 0.5);
  });

  test('computes the ratio of accepted requests that reached a succeeded payment', () {
    final requests = [
      request(1, ProcurementRequestStatus.accepted),
      request(2, ProcurementRequestStatus.accepted),
    ];
    final payments = [payment(1, PaymentIntentStatus.succeeded)];

    expect(ComputeCompletionRate.call(requests, payments), 0.5);
  });

  test('a failed payment does not count as completed', () {
    final requests = [request(1, ProcurementRequestStatus.accepted)];
    final payments = [payment(1, PaymentIntentStatus.failed)];

    expect(ComputeCompletionRate.call(requests, payments), 0.0);
  });
}
