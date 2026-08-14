import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_hotspot_stats.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';

AnonymizedListingEntity _listing(double lat, double lng, String category, DateTime recordedAt) =>
    AnonymizedListingEntity(
      hashedId: 'h',
      generalizedLat: lat,
      generalizedLng: lng,
      category: category,
      generalAge: '1980s',
      recordedAt: recordedAt,
      expireAt: recordedAt.add(const Duration(days: 365)),
    );

void main() {
  final now = DateTime.utc(2027, 6, 1);
  final since = now.subtract(const Duration(days: 7));

  test('groups by location+category and excludes records before "since"', () {
    final listings = [
      ..._many(3, () => _listing(49.19, -122.85, 'furniture', now)),
      ..._many(2, () => _listing(49.19, -122.85, 'electronics', now)),
      _listing(49.19, -122.85, 'furniture', since.subtract(const Duration(days: 1))),
    ];

    final stats = ComputeHotspotStats.call(listings, since, Random(1), epsilon: 1e6);

    expect(stats.length, 2); // stale record excluded, no 3rd furniture group
    final furniture = stats.firstWhere((s) => s.category == 'furniture');
    expect(furniture.count, 3); // negligible noise at epsilon=1e6
  });

  test('sorts busiest areas first', () {
    final listings = [
      ..._many(20, () => _listing(49.19, -122.85, 'furniture', now)),
      ..._many(2, () => _listing(50.0, -123.0, 'electronics', now)),
    ];

    final stats = ComputeHotspotStats.call(listings, since, Random(1), epsilon: 1e6);

    expect(stats.first.category, 'furniture');
    expect(stats.first.count, 20);
    expect(stats.last.count, 2);
  });

  test('an empty listing set produces no stats', () {
    expect(ComputeHotspotStats.call(const [], since, Random(1)), isEmpty);
  });
}

List<T> _many<T>(int n, T Function() build) => List.generate(n, (_) => build());
