import '../../../../objectbox.g.dart';
import '../entities/micro_credit_account_entity.dart';

/// Insert-or-update CRUD for micro-credit accounts (Issue #419),
/// mirroring [EscrowAccountRepository]'s upsert pattern.
class MicroCreditAccountRepository {
  final Box<MicroCreditAccountEntity> _box;

  MicroCreditAccountRepository(this._box);

  int save(MicroCreditAccountEntity account) => _box.put(account);

  List<MicroCreditAccountEntity> getAll() => _box.getAll();
}
