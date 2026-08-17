import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/accept_legal_terms.dart';
import 'package:growth_pilot_ai/business/needs_legal_reacceptance.dart';
import 'package:growth_pilot_ai/core/data/repositories/legal_consent_repository.dart';
import 'package:growth_pilot_ai/core/models/legal_consent_state.dart';

/// Drives the "Legal Acceptance" onboarding step and the version-mismatch
/// re-acceptance guard (Issue #215). [currentVersion] is this pipeline's
/// own `CURRENT_LEGAL_VERSION` — no NestJS endpoint exists to serve it
/// (see PR notes).
class LegalConsentController extends GetxController {
  static const currentVersion = 'v1.0.0';

  final LegalConsentRepository _repository;
  late final Rx<LegalConsentState> state;

  LegalConsentController(this._repository);

  @override
  void onInit() {
    super.onInit();
    final entity = _repository.get();
    state = LegalConsentState(
      acceptedVersion: entity.acceptedVersion,
      acceptedAt: entity.acceptedAt,
      dataUsageConsent: entity.dataUsageConsent,
    ).obs;
  }

  bool get needsAcceptance =>
      NeedsLegalReacceptance.call(state.value.acceptedVersion, currentVersion);

  void accept({required bool dataUsageConsent}) {
    state.value = AcceptLegalTerms.call(
      version: currentVersion,
      dataUsageConsent: dataUsageConsent,
      now: DateTime.now(),
    );
  }
}
