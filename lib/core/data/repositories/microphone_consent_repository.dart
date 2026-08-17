import '../../../../objectbox.g.dart';
import '../entities/microphone_consent_entity.dart';

/// Single-row CRUD for the microphone mock-consent toggle (Issue #540):
/// reads the one existing row if present, otherwise the opted-out
/// default.
class MicrophoneConsentRepository {
  final Box<MicrophoneConsentEntity> _box;

  MicrophoneConsentRepository(this._box);

  MicrophoneConsentEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? MicrophoneConsentEntity() : rows.first;
  }

  int save(MicrophoneConsentEntity state) => _box.put(state);
}
