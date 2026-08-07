import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_listings_within_radius.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

CatalogListingEntity _listing(double lat, double lng) {
  return CatalogListingEntity(
    ownerId: 'Alpha',
    title: 'Item',
    industry: 'Retail',
    locationLat: lat,
    locationLng: lng,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  // Surrey, BC
  const centerLat = 49.1913;
  const centerLng = -122.8490;

  test('includes a listing within the radius (Coquitlam, ~15km away)', () {
    final listings = [_listing(49.2838, -122.7932)];
    final result = FilterListingsWithinRadius.call(listings, centerLat, centerLng, 50);
    expect(result.length, 1);
  });

  test('excludes a listing outside the radius', () {
    final listings = [_listing(51.0447, -114.0719)]; // Calgary
    final result = FilterListingsWithinRadius.call(listings, centerLat, centerLng, 50);
    expect(result, isEmpty);
  });
}
