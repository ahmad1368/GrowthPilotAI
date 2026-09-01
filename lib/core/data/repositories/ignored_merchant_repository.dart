import '../../../../objectbox.g.dart';
import '../entities/ignored_merchant_entity.dart';

/// Thin ObjectBox wrapper for merchant-level false-positive suppression
/// (Issue #74).
class IgnoredMerchantRepository {
  final Box<IgnoredMerchantEntity> _box;

  IgnoredMerchantRepository(this._box);

  Set<String> getAllMerchantNames() =>
      _box.getAll().map((e) => e.merchantName).toSet();

  void upsert(IgnoredMerchantEntity entity) => _box.put(entity);
}
