import '../../../../objectbox.g.dart';
import '../entities/accounting_sync_status_entity.dart';

/// Thin ObjectBox wrapper for accounting push state (Issue #59), keyed by
/// [AccountingSyncStatusEntity.transactionId].
class AccountingSyncStatusRepository {
  final Box<AccountingSyncStatusEntity> _box;

  AccountingSyncStatusRepository(this._box);

  List<AccountingSyncStatusEntity> getAll() => _box.getAll();

  AccountingSyncStatusEntity? find(int transactionId) {
    final query = _box
        .query(AccountingSyncStatusEntity_.transactionId.equals(transactionId))
        .build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  void upsert(AccountingSyncStatusEntity status) {
    final existing = find(status.transactionId);
    if (existing != null) status.id = existing.id;
    _box.put(status);
  }
}
