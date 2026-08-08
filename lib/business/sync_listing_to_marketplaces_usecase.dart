import 'package:growth_pilot_ai/business/exponential_backoff.dart';
import 'package:growth_pilot_ai/business/find_or_create_marketplace_sync_status.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/marketplace_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/enum/marketplace_sync_status.dart';
import 'package:growth_pilot_ai/core/interfaces/marketplace_adapter.dart';

/// "Multi-Provider Registry" sync (Issue #127): pushes one listing to
/// every configured adapter, one at a time so one provider's failure
/// can't block another — mirrors [SyncConfirmedTransactionsUseCase]'s
/// (#59) retry/backoff bookkeeping. Returns only the touched statuses.
class SyncListingToMarketplacesUseCase {
  final List<MarketplaceAdapter> adapters;

  SyncListingToMarketplacesUseCase(this.adapters);

  Future<List<MarketplaceSyncStatusEntity>> syncListing(
    CatalogListingEntity listing,
    List<MarketplaceSyncStatusEntity> existingStatuses,
  ) async {
    final touched = <MarketplaceSyncStatusEntity>[];
    for (final adapter in adapters) {
      final status = FindOrCreateMarketplaceSyncStatus.call(
          existingStatuses, listing.id, adapter.providerName);
      if (status.isSynced || !_isDue(status)) continue;
      await _pushOne(status, adapter, listing);
      touched.add(status);
    }
    return touched;
  }

  bool _isDue(MarketplaceSyncStatusEntity status) {
    final nextRetryAt = status.nextRetryAt;
    return nextRetryAt == null || !DateTime.now().isBefore(nextRetryAt);
  }

  Future<void> _pushOne(MarketplaceSyncStatusEntity status, MarketplaceAdapter adapter,
      CatalogListingEntity listing) async {
    final response = await adapter.pushListing(listingId: listing.id, title: listing.title);
    status.lastAttemptAt = DateTime.now();

    if (response.success && response.data != null) {
      status.dbStatus = MarketplaceSyncStatus.synced.index;
      status.externalListingId = response.data;
      status.lastError = null;
      status.nextRetryAt = null;
      return;
    }
    status.dbStatus = MarketplaceSyncStatus.failed.index;
    status.retryCount += 1;
    status.lastError = response.message ?? 'Unknown sync error';
    status.nextRetryAt =
        DateTime.now().add(ExponentialBackoff.delayFor(status.retryCount - 1));
  }
}
