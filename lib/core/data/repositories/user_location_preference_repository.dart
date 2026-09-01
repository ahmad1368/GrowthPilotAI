import '../../../../objectbox.g.dart';
import '../entities/user_location_preference_entity.dart';

/// Get-or-create access to the single "My Location" preference row
/// (Issue #213, acceptance criterion "State Persistence").
class UserLocationPreferenceRepository {
  final Box<UserLocationPreferenceEntity> _box;

  UserLocationPreferenceRepository(this._box);

  UserLocationPreferenceEntity? get() => _box.getAll().firstOrNull;

  void setLocation(String postalCode, double lat, double lng) {
    final pref = get() ?? UserLocationPreferenceEntity(updatedAt: DateTime.now());
    pref.postalCode = postalCode;
    pref.lat = lat;
    pref.lng = lng;
    pref.updatedAt = DateTime.now();
    _box.put(pref);
  }
}
