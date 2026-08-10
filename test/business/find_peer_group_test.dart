import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_peer_group.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/peer_group_scope.dart';

AnonymizedListingEntity _listing(String category, double lat, double lng) =>
    AnonymizedListingEntity(
      hashedId: 'h',
      generalizedLat: lat,
      generalizedLng: lng,
      category: category,
      generalAge: '1980s',
      recordedAt: DateTime.utc(2027, 1, 1),
      expireAt: DateTime.utc(2028, 1, 1),
    );

void main() {
  test('uses the exact grid cell when it already has k members', () {
    final listings = List.generate(5, (_) => _listing('furniture', 49.19, -122.85));

    final result = FindPeerGroup.call(listings, 'furniture', 49.19, -122.85);

    expect(result.scope, PeerGroupScope.neighborhood);
    expect(result.peers.length, 5);
  });

  test('zooms out to the city grid when the exact cell is too sparse', () {
    final listings = [
      _listing('furniture', 49.19, -122.85), // exact cell: only 1
      ...List.generate(4, (_) => _listing('furniture', 49.21, -122.87)), // nearby, same city bucket
    ];

    final result = FindPeerGroup.call(listings, 'furniture', 49.19, -122.85);

    expect(result.scope, PeerGroupScope.city);
    expect(result.peers.length, 5);
  });

  test('zooms out to regional (category-only) when the city bucket is too sparse', () {
    final listings = [
      _listing('furniture', 49.19, -122.85),
      ...List.generate(4, (_) => _listing('furniture', 60.0, -130.0)), // far away, same category
    ];

    final result = FindPeerGroup.call(listings, 'furniture', 49.19, -122.85);

    expect(result.scope, PeerGroupScope.regional);
    expect(result.peers.length, 5);
  });

  test('returns Insufficient Data when even the regional group is too small', () {
    final listings = List.generate(4, (_) => _listing('furniture', 49.19, -122.85));

    final result = FindPeerGroup.call(listings, 'furniture', 49.19, -122.85);

    expect(result.scope, isNull);
    expect(result.peers, isEmpty);
    expect(result.isSufficient, isFalse);
  });

  test('never returns a group smaller than a custom k', () {
    final listings = List.generate(3, (_) => _listing('furniture', 49.19, -122.85));

    final result = FindPeerGroup.call(listings, 'furniture', 49.19, -122.85, k: 3);

    expect(result.scope, PeerGroupScope.neighborhood);
    expect(result.peers.length, 3);
  });
}
