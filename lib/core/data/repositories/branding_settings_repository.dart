import '../../../../objectbox.g.dart';
import '../entities/branding_settings_entity.dart';

/// Single-row ObjectBox wrapper for [BrandingSettingsEntity] — [get]
/// returns null until the user first saves branding, [save] always
/// upserts the same row by reusing its existing id.
class BrandingSettingsRepository {
  final Box<BrandingSettingsEntity> _box;

  BrandingSettingsRepository(this._box);

  BrandingSettingsEntity? get() {
    final all = _box.getAll();
    return all.isEmpty ? null : all.first;
  }

  void save(BrandingSettingsEntity settings) {
    final existing = get();
    if (existing != null) settings.id = existing.id;
    _box.put(settings);
  }
}
