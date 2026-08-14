import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/conflict_outcome.dart';
import 'package:growth_pilot_ai/core/models/cloud_transaction.dart';

/// Deterministic Last-Write-Wins conflict resolution between the local
/// ObjectBox record and the cloud record. Comparison is always in UTC.
class ConflictResolver {
  static ConflictOutcome resolve(
      TransactionEntity local, CloudTransaction cloud) {
    final l = local.lastModified.toUtc();
    final c = cloud.lastModified.toUtc();
    if (c.isAfter(l)) {
      return cloud.isDeleted
          ? ConflictOutcome.deleteBoth
          : ConflictOutcome.takeCloud;
    }
    if (l.isAfter(c)) {
      return local.isDeleted
          ? ConflictOutcome.deleteBoth
          : ConflictOutcome.pushLocal;
    }
    return ConflictOutcome.inSync;
  }

  /// Overwrites the local entity with the winning cloud values (LWW). The
  /// owning [TransactionEntity] identity/userId is never altered here — only
  /// mutable data and sync metadata. Persisting the change is the caller's job.
  static void applyCloud(TransactionEntity local, CloudTransaction cloud) {
    local.amount = cloud.amount;
    local.lastModified = cloud.lastModified.toUtc();
    local.isDeleted = cloud.isDeleted;
    local.syncStatus = SyncStatus.synced;
  }
}
