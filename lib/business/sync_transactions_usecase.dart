import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Client-side Delta Sync: uploads only the "dirty" (pending) transactions and
/// flips them to synced once the backend confirms — never on failure, so a
/// failed write can't leave records falsely marked as synced.
class SyncTransactionsUseCase {
  final RemoteSyncDataSource _source;

  SyncTransactionsUseCase(this._source);

  List<TransactionEntity> dirtyOf(List<TransactionEntity> all) =>
      all.where((t) => t.syncStatus == SyncStatus.pending).toList();

  OmniResult<List<int>> sync(List<TransactionEntity> all) async {
    final dirty = dirtyOf(all);
    if (dirty.isEmpty) {
      return OmniResponse.success(const <int>[], message: 'Nothing to sync');
    }

    final response = await _source.uploadTransactions(dirty);
    if (!response.success) {
      return OmniResponse.error(response.message ?? 'Sync failed',
          statusCode: response.statusCode);
    }

    final synced = response.data ?? const <int>[];
    for (final tx in dirty) {
      if (synced.contains(tx.id)) tx.syncStatus = SyncStatus.synced;
    }
    return OmniResponse.success(synced, message: 'Synced ${synced.length}');
  }
}
