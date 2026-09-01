import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/record_consent_action.dart';
import 'package:growth_pilot_ai/core/data/entities/microphone_consent_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/microphone_consent_repository.dart';
import 'package:growth_pilot_ai/core/enum/consent_action.dart';

/// Sets the mock microphone-monitoring toggle and appends an audit-log
/// entry in the same call (Issue #540, AC: "compliance audit logging
/// records when and how the user agreed"). `version: 'n/a'` — unlike the
/// #215 Terms of Service, this single toggle has no versioned document to
/// track.
class SetMicrophoneMonitoringConsent {
  static void call(bool optedIn, DateTime now) {
    final repository = GetIt.I<MicrophoneConsentRepository>();
    final existing = repository.get();
    repository.save(MicrophoneConsentEntity(id: existing.id, optedIn: optedIn, decidedAt: now));

    RecordConsentAction.call(
      optedIn ? ConsentAction.microphoneMonitoringOptIn : ConsentAction.microphoneMonitoringOptOut,
      'n/a',
      now,
    );
  }
}
