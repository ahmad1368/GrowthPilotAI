import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';

/// One append-only "High-Sensitivity" security-audit entry (Issue #186)
/// — [SecurityAuditLogRepository] exposes no update/delete, same WORM
/// pattern as #215's ConsentLogEntity. [platform] replaces the issue's
/// `ipAddress`/`userAgent` fields: this app has no server to observe a
/// request's IP (see PR notes). [metadata] must never contain PII or a
/// password, per the issue's own AC.
@Entity()
class SecurityAuditLogEntity {
  @Id()
  int id = 0;

  int dbActionType; // SecurityAuditActionType index
  int dbStatus; // SecurityAuditStatus index

  @Property(type: PropertyType.date)
  @Index()
  DateTime occurredAt;

  String? metadata;
  String platform;

  SecurityAuditLogEntity({
    this.id = 0,
    required this.dbActionType,
    required this.dbStatus,
    required this.occurredAt,
    this.metadata,
    required this.platform,
  });

  SecurityAuditActionType get actionType => SecurityAuditActionType.values[dbActionType];
  SecurityAuditStatus get status => SecurityAuditStatus.values[dbStatus];
}
