import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_or_create_marketplace_sync_status.dart';
import 'package:growth_pilot_ai/core/data/entities/marketplace_sync_status_entity.dart';

void main() {
  test('creates a new status row when none exists for this pair', () {
    final status = FindOrCreateMarketplaceSyncStatus.call([], 1, 'eBay');
    expect(status.listingId, 1);
    expect(status.providerName, 'eBay');
    expect(status.id, 0);
  });

  test('reuses the existing row for the same listing/provider pair', () {
    final existing = MarketplaceSyncStatusEntity(listingId: 1, providerName: 'eBay')..id = 9;
    final status = FindOrCreateMarketplaceSyncStatus.call([existing], 1, 'eBay');
    expect(identical(status, existing), isTrue);
  });

  test('does not reuse a row for a different provider on the same listing', () {
    final existing = MarketplaceSyncStatusEntity(listingId: 1, providerName: 'eBay');
    final status = FindOrCreateMarketplaceSyncStatus.call([existing], 1, 'Amazon');
    expect(identical(status, existing), isFalse);
  });
}
