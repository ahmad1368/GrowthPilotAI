import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/purge_stale_delivery_location_history.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_location_history_entity.dart';

void main() {
  final now = DateTime(2026, 2, 1);

  DeliveryLocationHistoryEntity entry(DateTime recordedAt) =>
      DeliveryLocationHistoryEntity(deliveryId: 1, lat: 0, lng: 0, recordedAt: recordedAt);

  test('keeps recent entries', () {
    final recent = entry(now.subtract(const Duration(days: 5)));
    expect(PurgeStaleDeliveryLocationHistory.call([recent], now), isEmpty);
  });

  test('flags entries older than 30 days for deletion', () {
    final stale = entry(now.subtract(const Duration(days: 31)));
    expect(PurgeStaleDeliveryLocationHistory.call([stale], now), [stale]);
  });
}
