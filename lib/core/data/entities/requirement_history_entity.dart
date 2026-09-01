import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';
import 'traceable_requirement_entity.dart';

/// One append-only audit entry for a requirement (Issue #238's
/// `requirement_history` table — a Temporal-Tables-style log, WORM
/// same as this repo's #186 `SecurityAuditLogEntity`) — no Postgres
/// trigger exists to catch direct DB edits, so every write must go
/// through [TraceabilityController] (see PR notes).
@Entity()
class RequirementHistoryEntity {
  @Id()
  int id = 0;

  final requirement = ToOne<TraceableRequirementEntity>();

  int dbChangeType; // RequirementChangeType index

  @Property(type: PropertyType.date)
  @Index()
  DateTime changedAt;

  String changedBy;
  String? oldValue;
  String? newValue;
  String reasonForChange;

  RequirementHistoryEntity({
    this.id = 0,
    required this.dbChangeType,
    required this.changedAt,
    required this.changedBy,
    this.oldValue,
    this.newValue,
    required this.reasonForChange,
  });

  RequirementChangeType get changeType => RequirementChangeType.values[dbChangeType];
}
