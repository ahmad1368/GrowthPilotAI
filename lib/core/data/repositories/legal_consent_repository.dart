import '../../../../objectbox.g.dart';
import '../entities/legal_consent_entity.dart';

/// Single-row CRUD for the current legal-acceptance status (Issue #215):
/// reads the one existing row if present, otherwise a not-yet-accepted
/// default.
class LegalConsentRepository {
  final Box<LegalConsentEntity> _box;

  LegalConsentRepository(this._box);

  LegalConsentEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? LegalConsentEntity() : rows.first;
  }

  int save(LegalConsentEntity state) => _box.put(state);
}
