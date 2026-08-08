import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_delivery_tracking_allowed.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  DeliveryEntity delivery({required bool consent, DeliveryStatus status = DeliveryStatus.inTransit}) =>
      DeliveryEntity(
          requestId: 1, paymentId: 1, courierId: 'c1', trackingConsentGiven: consent, createdAt: now)
        ..status = status;

  test('blocked without consent', () {
    expect(IsDeliveryTrackingAllowed.call(delivery(consent: false)), isFalse);
  });

  test('allowed with consent while in transit', () {
    expect(IsDeliveryTrackingAllowed.call(delivery(consent: true)), isTrue);
  });

  test('automatically terminated once completed', () {
    expect(
        IsDeliveryTrackingAllowed.call(delivery(consent: true, status: DeliveryStatus.completed)),
        isFalse);
  });

  test('blocked once canceled', () {
    expect(
        IsDeliveryTrackingAllowed.call(delivery(consent: true, status: DeliveryStatus.canceled)),
        isFalse);
  });
}
