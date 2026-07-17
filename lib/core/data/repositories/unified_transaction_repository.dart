import 'package:growth_pilot_ai/business/seed_demo_unified_transactions.dart';

import '../../../../objectbox.g.dart';
import '../entities/unified_transaction_entity.dart';

/// Thin ObjectBox wrapper for the Duplicate Matches screen's records
/// (Issue #69). Upserts by [UnifiedTransactionEntity.externalId].
class UnifiedTransactionRepository {
  final Box<UnifiedTransactionEntity> _box;

  UnifiedTransactionRepository(this._box);

  List<UnifiedTransactionEntity> getAll() => _box.getAll();

  void upsert(UnifiedTransactionEntity entity) {
    final query = _box
        .query(UnifiedTransactionEntity_.externalId.equals(entity.externalId))
        .build();
    final existing = query.findFirst();
    query.close();
    if (existing != null) entity.id = existing.id;
    _box.put(entity);
  }

  void seedIfEmpty() {
    for (final seed in SeedDemoUnifiedTransactions.call(getAll())) {
      upsert(seed);
    }
  }
}
