import 'package:growth_pilot_ai/core/data/entities/marketplace_sync_status_entity.dart';

/// One sync-status row per (listing, provider) pair (Issue #127) —
/// reuses the existing row if this pair was already tracked.
class FindOrCreateMarketplaceSyncStatus {
  static MarketplaceSyncStatusEntity call(
    List<MarketplaceSyncStatusEntity> existing,
    int listingId,
    String providerName,
  ) {
    for (final status in existing) {
      if (status.listingId == listingId && status.providerName == providerName) {
        return status;
      }
    }
    return MarketplaceSyncStatusEntity(listingId: listingId, providerName: providerName);
  }
}
