import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';

/// The "searchable" requirement (Issue #186) — filters by action type
/// and/or date range, newest first, for the Compliance Auditor's
/// "chronological record of every sensitive action" user story.
class SearchSecurityAuditLogs {
  static List<SecurityAuditLogEntity> call(
    List<SecurityAuditLogEntity> logs, {
    SecurityAuditActionType? actionType,
    DateTime? from,
    DateTime? to,
  }) {
    final filtered = logs.where((log) {
      if (actionType != null && log.actionType != actionType) return false;
      if (from != null && log.occurredAt.isBefore(from)) return false;
      if (to != null && log.occurredAt.isAfter(to)) return false;
      return true;
    }).toList();

    filtered.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return filtered;
  }
}
