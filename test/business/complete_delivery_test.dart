import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/complete_delivery.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

void main() {
  test('marks the delivery completed with a completion timestamp', () {
    final now = DateTime(2026, 1, 1);
    final delivery =
        DeliveryEntity(requestId: 1, paymentId: 1, courierId: 'c1', createdAt: now);

    CompleteDelivery.call(delivery, now);

    expect(delivery.status, DeliveryStatus.completed);
    expect(delivery.completedAt, now);
  });
}
