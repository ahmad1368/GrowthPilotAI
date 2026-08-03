import '../../../../objectbox.g.dart';
import '../entities/merchant_config_entity.dart';

/// Insert-or-update CRUD for merchant configuration profiles (Issue
/// #338). `save` reuses ObjectBox `put`'s id semantics: `id == 0`
/// inserts a new profile, a non-zero `id` overwrites the existing one
/// in place, so edits take effect immediately.
class MerchantConfigRepository {
  final Box<MerchantConfigEntity> _box;

  MerchantConfigRepository(this._box);

  int save(MerchantConfigEntity config) => _box.put(config);

  List<MerchantConfigEntity> getAll() => _box.getAll();
}
