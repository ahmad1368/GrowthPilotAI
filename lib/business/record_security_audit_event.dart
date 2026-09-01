import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/current_client_platform_label.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_audit_log_repository.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';

/// Appends one entry to the immutable security-audit trail (Issue #186).
/// [metadata] must never contain PII or a password, per the issue's own
/// AC — callers are responsible for passing only safe summary text
/// (e.g. "Exported 42 records").
class RecordSecurityAuditEvent {
  static void call(
    SecurityAuditActionType actionType,
    SecurityAuditStatus status,
    DateTime now, {
    String? metadata,
  }) {
    GetIt.I<SecurityAuditLogRepository>().add(SecurityAuditLogEntity(
      dbActionType: actionType.index,
      dbStatus: status.index,
      occurredAt: now,
      metadata: metadata,
      platform: CurrentClientPlatformLabel.call(),
    ));
  }
}
