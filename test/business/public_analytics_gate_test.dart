import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/public_analytics_gate.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';

AnonymizedListingEntity _listing(double lat, double lng, String age) =>
    AnonymizedListingEntity(
      hashedId: 'h',
      generalizedLat: lat,
      generalizedLng: lng,
      category: 'x',
      generalAge: age,
      recordedAt: DateTime.utc(2027, 1, 1),
      expireAt: DateTime.utc(2027, 2, 1),
    );

void main() {
  test('drops a shadow record whose location+age group is smaller than k', () {
    final listings = [
      for (var i = 0; i < 5; i++) _listing(49.19, -122.85, '1980s'),
      _listing(50.0, -123.0, '1990s'), // group of 1
    ];

    final filtered = PublicAnalyticsGate.filter(listings, k: 5);

    expect(filtered.length, 5);
    expect(filtered.every((l) => l.generalAge == '1980s'), isTrue);
  });

  test('an empty store returns an empty list', () {
    expect(PublicAnalyticsGate.filter(const []), isEmpty);
  });
}
