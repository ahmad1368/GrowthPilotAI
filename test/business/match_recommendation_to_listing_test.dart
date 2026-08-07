import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/match_recommendation_to_listing.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';

WholesaleListingEntity _listing(String itemName, WholesaleListingStatus status) {
  return WholesaleListingEntity(
    inventoryItemId: 1,
    itemName: itemName,
    quantityListed: 10,
    wholesalePrice: 5,
    dbStatus: status.index,
    listedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('matches an active listing by item name, case-insensitively', () {
    final listings = [_listing('Espresso Beans', WholesaleListingStatus.active)];
    final match = MatchRecommendationToListing.call('espresso beans', listings);
    expect(match, isNotNull);
    expect(match!.itemName, 'Espresso Beans');
  });

  test('ignores sold/cancelled listings', () {
    final listings = [
      _listing('Espresso Beans', WholesaleListingStatus.sold),
      _listing('Espresso Beans', WholesaleListingStatus.cancelled),
    ];
    expect(MatchRecommendationToListing.call('Espresso Beans', listings), isNull);
  });

  test('returns null when no listing matches', () {
    expect(MatchRecommendationToListing.call('Unknown Item', []), isNull);
  });
}
