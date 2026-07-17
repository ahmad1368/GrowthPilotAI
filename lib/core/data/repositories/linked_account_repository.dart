import 'package:growth_pilot_ai/business/seed_linked_accounts.dart';

import '../../../../objectbox.g.dart';
import '../entities/linked_account_entity.dart';

/// Thin ObjectBox wrapper for the Connected Accounts screen's sub-account
/// rows (Issue #68). Upserts by [LinkedAccountEntity.accountId].
class LinkedAccountRepository {
  final Box<LinkedAccountEntity> _box;

  LinkedAccountRepository(this._box);

  List<LinkedAccountEntity> getAll() => _box.getAll();

  void upsert(LinkedAccountEntity entity) {
    final query = _box
        .query(LinkedAccountEntity_.accountId.equals(entity.accountId))
        .build();
    final existing = query.findFirst();
    query.close();
    if (existing != null) entity.id = existing.id;
    _box.put(entity);
  }

  void seedIfEmpty() {
    for (final seed in SeedLinkedAccounts.call(getAll())) {
      upsert(seed);
    }
  }
}
