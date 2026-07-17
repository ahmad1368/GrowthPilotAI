import 'package:growth_pilot_ai/business/exponential_backoff.dart';
import 'package:growth_pilot_ai/core/data/entities/accounting_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/enum/accounting_sync_status.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "Sync to Cloud" (Issue #59): pushes every not-yet-synced status to
/// QuickBooks/Xero, one at a time so one failure can't block the batch.
/// Already-synced or still-backed-off statuses are left untouched — the
/// dedupe/idempotency + rate-limit guard the issue calls for.
class SyncConfirmedTransactionsUseCase {
  final AccountingExportService _exportService;

  SyncConfirmedTransactionsUseCase(this._exportService);

  Future<void> syncAll(
      List<AccountingSyncStatusEntity> statuses, String accountId) async {
    for (final status in statuses) {
      if (status.isSynced || !_isDue(status)) continue;
      await _pushOne(status, accountId);
    }
  }

  bool _isDue(AccountingSyncStatusEntity status) {
    final nextRetryAt = status.nextRetryAt;
    return nextRetryAt == null || !DateTime.now().isBefore(nextRetryAt);
  }

  Future<void> _pushOne(
      AccountingSyncStatusEntity status, String accountId) async {
    final response = await _exportService.pushTransaction(
        transactionId: status.transactionId, accountId: accountId);
    status.lastAttemptAt = DateTime.now();

    if (response.success && response.data != null) {
      status.dbStatus = AccountingSyncStatus.synced.index;
      status.externalProviderId = response.data;
      status.lastError = null;
      status.nextRetryAt = null;
      return;
    }
    status.dbStatus = AccountingSyncStatus.failed.index;
    status.retryCount += 1;
    status.lastError = response.message ?? 'Unknown export error';
    status.nextRetryAt =
        DateTime.now().add(ExponentialBackoff.delayFor(status.retryCount - 1));
    OmniLogger.warning('Accounting export failed for tx '
        '${status.transactionId} (attempt ${status.retryCount}): ${status.lastError}');
  }
}
