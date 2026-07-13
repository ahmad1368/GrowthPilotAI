import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sync_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';

/// Datasource that always rejects the upload, to verify consistency.
class _FailingSource implements RemoteSyncDataSource {
  @override
  SyncConfig get config => const SyncConfig(baseUrl: '');
  @override
  OmniResult<bool> healthCheck() async => OmniResponse.error('down');
  @override
  OmniResult<List<int>> uploadTransactions(List<TransactionEntity> d) async =>
      OmniResponse.error('write failed', statusCode: 500);
}

TransactionEntity _tx(int id, {required bool pending}) {
  final tx = TransactionEntity(
      id: id, amount: 10, date: DateTime(2027, 1, 1), description: 'x');
  tx.syncStatus = pending ? SyncStatus.pending : SyncStatus.synced;
  return tx;
}

void main() {
  final configured =
      MockRemoteSyncDataSource(const SyncConfig(baseUrl: 'https://api.x'));

  test('dirtyOf returns only pending records', () {
    final all = [_tx(1, pending: true), _tx(2, pending: false)];
    final dirty = SyncTransactionsUseCase(configured).dirtyOf(all);
    expect(dirty.map((t) => t.id), [1]);
  });

  test('sync uploads dirty records and flips them to synced', () async {
    final all = [
      _tx(1, pending: true),
      _tx(2, pending: false),
      _tx(3, pending: true),
    ];
    final response = await SyncTransactionsUseCase(configured).sync(all);

    expect(response.success, isTrue);
    expect(response.data, [1, 3]);
    expect(all[0].syncStatus, SyncStatus.synced);
    expect(all[2].syncStatus, SyncStatus.synced);
  });

  test('sync with no dirty records is a no-op success', () async {
    final all = [_tx(1, pending: false)];
    final response = await SyncTransactionsUseCase(configured).sync(all);
    expect(response.success, isTrue);
    expect(response.data, isEmpty);
  });

  test('a failed upload leaves records pending (no false success)', () async {
    final all = [_tx(1, pending: true)];
    final response = await SyncTransactionsUseCase(_FailingSource()).sync(all);

    expect(response.success, isFalse);
    expect(all[0].syncStatus, SyncStatus.pending);
  });
}
