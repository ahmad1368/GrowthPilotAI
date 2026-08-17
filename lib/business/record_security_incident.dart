import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/security_incident_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_incident_repository.dart';
import 'package:growth_pilot_ai/core/enum/breach_incident_status.dart';

/// Logs one new incident (Issue #187) — [dataInvolved] should describe
/// data categories (e.g. "names, transaction history"), never the
/// compromised secret itself.
class RecordSecurityIncident {
  static SecurityIncidentEntity call(String summary, String dataInvolved, DateTime now) {
    final entity = SecurityIncidentEntity(
      summary: summary,
      dataInvolved: dataInvolved,
      dbStatus: BreachIncidentStatus.detected.index,
      detectedAt: now,
    );
    entity.id = GetIt.I<SecurityIncidentRepository>().upsert(entity);
    return entity;
  }
}
