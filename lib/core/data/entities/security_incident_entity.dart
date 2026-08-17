import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/breach_incident_status.dart';

/// One logged security incident (Issue #187's `SecurityIncidents` table)
/// — [summary]/[dataInvolved] must never contain a stolen password or
/// other secret itself (AC: "Privacy by Design... don't include the
/// stolen password in the email"). Status legitimately progresses
/// (detected -> ... -> resolved), unlike the append-only
/// [BreachNotificationLogEntity] compliance record.
@Entity()
class SecurityIncidentEntity {
  @Id()
  int id = 0;

  String summary;
  String dataInvolved;
  int dbStatus; // BreachIncidentStatus index

  @Property(type: PropertyType.date)
  DateTime detectedAt;

  SecurityIncidentEntity({
    this.id = 0,
    required this.summary,
    required this.dataInvolved,
    required this.dbStatus,
    required this.detectedAt,
  });

  BreachIncidentStatus get status => BreachIncidentStatus.values[dbStatus];
}
