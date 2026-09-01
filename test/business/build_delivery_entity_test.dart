import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_delivery_entity.dart';
import 'package:growth_pilot_ai/business/build_delivery_location_history_entry.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('builds a pending delivery with the given consent flag', () {
    final delivery = BuildDeliveryEntity.call(1, 2, 'courier-1', consentGiven: true, now: now);

    expect(delivery.requestId, 1);
    expect(delivery.paymentId, 2);
    expect(delivery.trackingConsentGiven, isTrue);
    expect(delivery.status, DeliveryStatus.pending);
  });

  test('builds a route-history entry for a delivery', () {
    final entry = BuildDeliveryLocationHistoryEntry.call(1, 49.28, -123.12, now);

    expect(entry.deliveryId, 1);
    expect(entry.lat, 49.28);
    expect(entry.recordedAt, now);
  });
}
