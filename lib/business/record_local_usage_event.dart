import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/should_record_usage_event.dart';
import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/legal_consent_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/local_usage_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

/// Logs one in-app usage event, but only if #215's `dataUsageConsent` is
/// currently granted (Issue #539's local, honest reinterpretation of
/// "tracking" — see PR notes).
class RecordLocalUsageEvent {
  static void call(UsageEventType type, String label, DateTime now) {
    final consent = GetIt.I<LegalConsentRepository>().get().dataUsageConsent;
    if (!ShouldRecordUsageEvent.call(consent)) return;

    GetIt.I<LocalUsageEventRepository>()
        .add(LocalUsageEventEntity(dbType: type.index, label: label, occurredAt: now));
  }
}
