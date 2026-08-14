import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sync_listing_to_marketplaces_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/marketplace_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/enum/marketplace_sync_status.dart';
import 'package:growth_pilot_ai/core/interfaces/marketplace_adapter.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

class _SpyAdapter implements MarketplaceAdapter {
  final bool succeeds;
  _SpyAdapter({this.succeeds = true});

  @override
  String get providerName => 'eBay';

  @override
  OmniResult<String> pushListing({required int listingId, required String title}) async =>
      succeeds ? OmniResponse.success('ext-$listingId') : OmniResponse.error('boom');

  @override
  OmniResult<void> updateAvailability({required String externalListingId, required bool isAvailable}) async =>
      OmniResponse.success(null);
}

void main() {
  final listing = CatalogListingEntity(
      id: 1, ownerId: 'vendor-1', title: 'Widget', industry: 'auto', createdAt: DateTime(2026, 1, 1));

  test('marks the status synced on a successful push', () async {
    final usecase = SyncListingToMarketplacesUseCase([_SpyAdapter()]);
    final touched = await usecase.syncListing(listing, []);

    expect(touched, hasLength(1));
    expect(touched.single.status, MarketplaceSyncStatus.synced);
    expect(touched.single.externalListingId, 'ext-1');
  });

  test('schedules a backoff retry on failure', () async {
    final usecase = SyncListingToMarketplacesUseCase([_SpyAdapter(succeeds: false)]);
    final touched = await usecase.syncListing(listing, []);

    expect(touched.single.status, MarketplaceSyncStatus.failed);
    expect(touched.single.retryCount, 1);
    expect(touched.single.nextRetryAt, isNotNull);
  });

  test('skips a provider that is already synced', () async {
    final alreadySynced = MarketplaceSyncStatusEntity(listingId: 1, providerName: 'eBay')
      ..dbStatus = MarketplaceSyncStatus.synced.index;
    final usecase = SyncListingToMarketplacesUseCase([_SpyAdapter()]);
    final touched = await usecase.syncListing(listing, [alreadySynced]);

    expect(touched, isEmpty);
  });
}
