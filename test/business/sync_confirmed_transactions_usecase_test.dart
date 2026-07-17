import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sync_confirmed_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/accounting_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/enum/accounting_sync_status.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Fake that always rejects the push, to verify retry/backoff bookkeeping.
class _FailingExportService implements AccountingExportService {
  int callCount = 0;
  @override
  OmniResult<String> pushTransaction(
      {required int transactionId, required String accountId}) async {
    callCount++;
    return OmniResponse.error('provider down', statusCode: 503);
  }
}

/// Fake that always accepts the push, returning a deterministic external id.
class _SucceedingExportService implements AccountingExportService {
  int callCount = 0;
  @override
  OmniResult<String> pushTransaction(
      {required int transactionId, required String accountId}) async {
    callCount++;
    return OmniResponse.success('ext-$transactionId');
  }
}

void main() {
  test('a successful push marks the status synced with the external id', () async {
    final service = _SucceedingExportService();
    final status = AccountingSyncStatusEntity(transactionId: 1);

    await SyncConfirmedTransactionsUseCase(service).syncAll([status], 'acc-1');

    expect(status.status, AccountingSyncStatus.synced);
    expect(status.externalProviderId, 'ext-1');
    expect(status.nextRetryAt, isNull);
  });

  test('a failed push increments retryCount and schedules a backoff window',
      () async {
    final service = _FailingExportService();
    final status = AccountingSyncStatusEntity(transactionId: 2);

    await SyncConfirmedTransactionsUseCase(service).syncAll([status], 'acc-1');

    expect(status.status, AccountingSyncStatus.failed);
    expect(status.retryCount, 1);
    expect(status.lastError, isNotNull);
    expect(status.nextRetryAt!.isAfter(DateTime.now()), isTrue);
  });

  test('an already-synced status is never pushed again (dedupe)', () async {
    final service = _SucceedingExportService();
    final status = AccountingSyncStatusEntity(
        transactionId: 3,
        dbStatus: AccountingSyncStatus.synced.index,
        externalProviderId: 'ext-3');

    await SyncConfirmedTransactionsUseCase(service).syncAll([status], 'acc-1');

    expect(service.callCount, 0);
  });

  test('a status still inside its backoff window is skipped', () async {
    final service = _FailingExportService();
    final status = AccountingSyncStatusEntity(
      transactionId: 4,
      dbStatus: AccountingSyncStatus.failed.index,
      retryCount: 1,
      nextRetryAt: DateTime.now().add(const Duration(minutes: 5)),
    );

    await SyncConfirmedTransactionsUseCase(service).syncAll([status], 'acc-1');

    expect(service.callCount, 0);
    expect(status.retryCount, 1);
  });
}
