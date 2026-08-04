import '../../../../objectbox.g.dart';
import '../entities/account_suspension_entity.dart';

/// Insert-or-update CRUD for account suspensions (Issue #341), mirroring
/// [MerchantConfigRepository]'s upsert pattern.
class AccountSuspensionRepository {
  final Box<AccountSuspensionEntity> _box;

  AccountSuspensionRepository(this._box);

  int save(AccountSuspensionEntity suspension) => _box.put(suspension);

  List<AccountSuspensionEntity> getAll() => _box.getAll();
}
