import '../../../../objectbox.g.dart';
import '../entities/business_contact_visibility_entity.dart';

/// Single-row CRUD for the business's contact-field visibility settings
/// (Issue #218): reads the one existing row if present, otherwise the
/// all-private default.
class BusinessContactVisibilityRepository {
  final Box<BusinessContactVisibilityEntity> _box;

  BusinessContactVisibilityRepository(this._box);

  BusinessContactVisibilityEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? BusinessContactVisibilityEntity() : rows.first;
  }

  int save(BusinessContactVisibilityEntity settings) => _box.put(settings);
}
