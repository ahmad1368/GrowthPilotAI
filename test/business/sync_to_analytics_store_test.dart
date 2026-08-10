import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sync_to_analytics_store.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';

void main() {
  final pepper = HashPepper('test-pepper');

  test('builds a shadow record with hashed id and generalized fields', () {
    final listing = SyncToAnalyticsStore.call(
      rawId: 'raw-id-1',
      lat: 49.1913,
      lng: -122.8490,
      category: 'furniture',
      approximateAgeYear: 1989,
      createdAt: DateTime.utc(2027, 3, 14, 15, 37, 22),
      pepper: pepper,
    );

    expect(listing.hashedId, isNot('raw-id-1'));
    expect(listing.hashedId, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(listing.generalizedLat, 49.19);
    expect(listing.generalizedLng, -122.85);
    expect(listing.category, 'furniture');
    expect(listing.generalAge, '1980s');
    expect(listing.recordedAt, DateTime.utc(2027, 3, 14, 15));
  });

  test('the same raw id always produces the same hash (deterministic)', () {
    final a = SyncToAnalyticsStore.call(
      rawId: 'raw-id-1',
      lat: 0,
      lng: 0,
      category: 'x',
      approximateAgeYear: 2000,
      createdAt: DateTime.utc(2027, 1, 1),
      pepper: pepper,
    );
    final b = SyncToAnalyticsStore.call(
      rawId: 'raw-id-1',
      lat: 0,
      lng: 0,
      category: 'x',
      approximateAgeYear: 2000,
      createdAt: DateTime.utc(2027, 1, 1),
      pepper: pepper,
    );
    expect(a.hashedId, b.hashedId);
  });
}
