import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_peer_relevance_score.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';

AnonymizedListingEntity _listing(double lat, double lng) => AnonymizedListingEntity(
      hashedId: 'h',
      generalizedLat: lat,
      generalizedLng: lng,
      category: 'furniture',
      generalAge: '1980s',
      recordedAt: DateTime.utc(2027, 1, 1),
      expireAt: DateTime.utc(2028, 1, 1),
    );

void main() {
  test('a peer in the same grid cell scores full relevance', () {
    final peer = _listing(49.19, -122.85);
    expect(ComputePeerRelevanceScore.call(peer, 49.19, -122.85), 100);
  });

  test('a peer in a different grid cell takes the location penalty', () {
    final peer = _listing(50.0, -123.0);
    expect(ComputePeerRelevanceScore.call(peer, 49.19, -122.85), 70);
  });
}
