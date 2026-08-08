import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/search_catalog_listings.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

CatalogListingEntity _listing(String title, double lat, double lng) => CatalogListingEntity(
      ownerId: 'owner',
      title: title,
      industry: 'test',
      locationLat: lat,
      locationLng: lng,
      createdAt: DateTime(2026),
    );

void main() {
  const centerLat = 49.2827, centerLng = -123.1207; // Vancouver

  test('ranks exact text matches above weaker ones', () {
    final exact = _listing('Surrey Bakery', 0, 0);
    final weak = _listing('Surrey-ish Cafe', 0, 0);
    final results = SearchCatalogListings.call([weak, exact], 'Surrey Bakery');
    expect(results.first.listing.title, 'Surrey Bakery');
  });

  test('excludes listings outside the radius when a center is given', () {
    final near = _listing('Near', 49.2911, -122.8069);
    final far = _listing('Far', 51.0447, -114.0719);
    final results = SearchCatalogListings.call(
      [near, far],
      '',
      centerLat: centerLat,
      centerLng: centerLng,
      radiusKm: 50,
    );
    expect(results.map((r) => r.listing.title), ['Near']);
  });

  test('excludes listings below the minimum match score', () {
    final results = SearchCatalogListings.call([_listing('Bakery', 0, 0)], 'zzzxyq');
    expect(results, isEmpty);
  });
}
