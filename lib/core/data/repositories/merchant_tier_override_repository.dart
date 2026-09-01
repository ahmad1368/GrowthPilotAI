import '../../../../objectbox.g.dart';
import '../entities/merchant_tier_override_entity.dart';

/// Insert-or-update CRUD for admin tier overrides (Issue #425,
/// acceptance criterion 5), mirroring [WholesaleOrderRepository]'s
/// upsert pattern, plus clearing a merchant's override entirely.
class MerchantTierOverrideRepository {
  final Box<MerchantTierOverrideEntity> _box;

  MerchantTierOverrideRepository(this._box);

  int save(MerchantTierOverrideEntity override) => _box.put(override);

  List<MerchantTierOverrideEntity> getAll() => _box.getAll();

  MerchantTierOverrideEntity? forMerchant(String merchantName) =>
      getAll().where((o) => o.merchantName == merchantName).firstOrNull;

  void clear(String merchantName) {
    final existing = forMerchant(merchantName);
    if (existing != null) _box.remove(existing.id);
  }
}
