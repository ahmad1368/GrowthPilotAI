import '../../../../objectbox.g.dart';
import '../entities/transaction_mapping_status_entity.dart';

/// Thin ObjectBox wrapper for confirmed transaction-to-account mappings
/// (Issue #58 — "Confirm" action on the Category Mapping screen).
class TransactionMappingStatusRepository {
  final Box<TransactionMappingStatusEntity> _box;

  TransactionMappingStatusRepository(this._box);

  void confirm(TransactionMappingStatusEntity status) {
    final query = _box
        .query(TransactionMappingStatusEntity_.transactionId
            .equals(status.transactionId))
        .build();
    final existing = query.findFirst();
    query.close();
    if (existing != null) status.id = existing.id;
    _box.put(status);
  }

  Set<int> confirmedTransactionIds() =>
      _box.getAll().map((e) => e.transactionId).toSet();
}
