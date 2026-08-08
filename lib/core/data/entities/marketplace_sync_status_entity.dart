import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/marketplace_sync_status.dart';

/// Push state of one [listingId] to one external [providerName] (Issue
/// #127) — one row per listing/provider pair, mirroring
/// [AccountingSyncStatusEntity]'s (#59) retry/backoff bookkeeping.
@Entity()
class MarketplaceSyncStatusEntity {
  @Id()
  int id = 0;

  @Index()
  int listingId;

  @Index()
  String providerName;

  int dbStatus; // MarketplaceSyncStatus index
  String? externalListingId;
  int retryCount;
  DateTime? lastAttemptAt;
  DateTime? nextRetryAt;
  String? lastError;

  MarketplaceSyncStatusEntity({
    this.id = 0,
    required this.listingId,
    required this.providerName,
    this.dbStatus = 0, // MarketplaceSyncStatus.pending
    this.externalListingId,
    this.retryCount = 0,
    this.lastAttemptAt,
    this.nextRetryAt,
    this.lastError,
  });

  MarketplaceSyncStatus get status => MarketplaceSyncStatus.values[dbStatus];
  bool get isSynced => status == MarketplaceSyncStatus.synced;
}
