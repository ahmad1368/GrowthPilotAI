import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/accounting_sync_status.dart';

/// Push state of one confirmed mapping (Issue #58) to QuickBooks/Xero
/// (Issue #59). One row per [transactionId]; [externalProviderId] is the
/// dedupe key that stops a re-run from posting the same ledger entry twice.
@Entity()
class AccountingSyncStatusEntity {
  @Id()
  int id = 0;

  @Unique()
  int transactionId;

  int dbStatus; // AccountingSyncStatus index
  String? externalProviderId;
  int retryCount;
  DateTime? lastAttemptAt;
  DateTime? nextRetryAt;
  String? lastError;

  AccountingSyncStatusEntity({
    this.id = 0,
    required this.transactionId,
    this.dbStatus = 0, // AccountingSyncStatus.pending
    this.externalProviderId,
    this.retryCount = 0,
    this.lastAttemptAt,
    this.nextRetryAt,
    this.lastError,
  });

  AccountingSyncStatus get status => AccountingSyncStatus.values[dbStatus];
  bool get isSynced => status == AccountingSyncStatus.synced;
}
