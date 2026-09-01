import '../../../../objectbox.g.dart';
import '../entities/feature_module_toggle_entity.dart';

/// Insert-or-update CRUD for feature module toggles (Issue #339). `save`
/// reuses ObjectBox `put`'s id semantics, mirroring
/// [MerchantConfigRepository]'s upsert pattern.
class FeatureModuleToggleRepository {
  final Box<FeatureModuleToggleEntity> _box;

  FeatureModuleToggleRepository(this._box);

  int save(FeatureModuleToggleEntity toggle) => _box.put(toggle);

  List<FeatureModuleToggleEntity> getAll() => _box.getAll();
}
