import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/record_consent_action.dart';
import 'package:growth_pilot_ai/core/data/entities/legal_consent_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/legal_consent_repository.dart';
import 'package:growth_pilot_ai/core/enum/consent_action.dart';
import 'package:growth_pilot_ai/core/models/legal_consent_state.dart';

/// "Active Consent" acceptance workflow (Issue #215): records the
/// accepted version and appends an immutable audit-log entry in the same
/// action, so the two can never drift apart.
class AcceptLegalTerms {
  static LegalConsentState call({
    required String version,
    required bool dataUsageConsent,
    required DateTime now,
  }) {
    final repository = GetIt.I<LegalConsentRepository>();
    final existing = repository.get();
    repository.save(LegalConsentEntity(
      id: existing.id,
      acceptedVersion: version,
      acceptedAt: now,
      dataUsageConsent: dataUsageConsent,
    ));
    RecordConsentAction.call(ConsentAction.termsAccepted, version, now);

    return LegalConsentState(
        acceptedVersion: version, acceptedAt: now, dataUsageConsent: dataUsageConsent);
  }
}
