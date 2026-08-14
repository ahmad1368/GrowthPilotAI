import '../../../../objectbox.g.dart';
import '../entities/escrow_account_entity.dart';

/// Insert-or-update CRUD for escrow accounts (Issue #415), mirroring
/// [GroupPurchaseRepository]'s upsert pattern.
class EscrowAccountRepository {
  final Box<EscrowAccountEntity> _box;

  EscrowAccountRepository(this._box);

  int save(EscrowAccountEntity account) => _box.put(account);

  List<EscrowAccountEntity> getAll() => _box.getAll();
}
