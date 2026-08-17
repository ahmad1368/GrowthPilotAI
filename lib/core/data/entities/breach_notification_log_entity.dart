import 'package:objectbox/objectbox.dart';

/// One append-only "Compliance Log" entry recording that a breach
/// notification was sent for an incident (Issue #187, AC: "All breach
/// notifications are recorded in an immutable Compliance Log") —
/// [BreachNotificationLogRepository] exposes no update/delete, same WORM
/// pattern as #186's SecurityAuditLogEntity.
@Entity()
class BreachNotificationLogEntity {
  @Id()
  int id = 0;

  int incidentId;

  @Property(type: PropertyType.date)
  DateTime notifiedAt;

  String platform;

  BreachNotificationLogEntity({
    this.id = 0,
    required this.incidentId,
    required this.notifiedAt,
    required this.platform,
  });
}
