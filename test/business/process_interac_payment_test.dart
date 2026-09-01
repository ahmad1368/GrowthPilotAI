import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/process_interac_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  PaymentEntity payment() => PaymentEntity(
      invoiceId: 1, requestId: 1, buyerId: 'buyer', sellerId: 'vendor', amount: 100, createdAt: now);

  test('marks the payment succeeded with a valid reference', () {
    final p = payment();
    final result = ProcessInteracPayment.call(p, 'REF123456', now);

    expect(result, isTrue);
    expect(p.status, PaymentIntentStatus.succeeded);
    expect(p.interacReferenceNumber, 'REF123456');
    expect(p.completedAt, now);
  });

  test('leaves the payment untouched with an invalid reference', () {
    final p = payment();
    final result = ProcessInteracPayment.call(p, 'x', now);

    expect(result, isFalse);
    expect(p.status, PaymentIntentStatus.created);
    expect(p.interacReferenceNumber, isNull);
  });
}
