import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_nearby_listings.dart';
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

  test('excludes listings outside the radius', () {
    final near = _listing('Near', 49.2911, -122.8069); // Coquitlam, ~24km
    final far = _listing('Far', 51.0447, -114.0719); // Calgary, far away
    final result = FindNearbyListings.call([near, far], centerLat, centerLng, 50);
    expect(result.map((r) => r.listing.title), ['Near']);
  });

  test('sorts nearest-first', () {
    final closer = _listing('Closer', 49.28, -123.12);
    final farther = _listing('Farther', 49.2911, -122.8069);
    final result = FindNearbyListings.call([farther, closer], centerLat, centerLng, 50);
    expect(result.first.listing.title, 'Closer');
    expect(result.first.distanceKm, lessThan(result.last.distanceKm));
  });

  test('caps to maxResults', () {
    final listings = List.generate(5, (i) => _listing('L$i', centerLat, centerLng));
    final result = FindNearbyListings.call(listings, centerLat, centerLng, 50, maxResults: 2);
    expect(result.length, 2);
  });
}
