import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';

/// "Audit Integration" (Issue #187): flags a mass data-export attempt as
/// a Potential Breach Event by counting #186's `dataExport` audit-log
/// entries within a trailing window — the app has no server-side
/// unauthorized-access detection to integrate with (see PR notes), so
/// this is the local equivalent signal.
class DetectMassDataExport {
  static const defaultThreshold = 5;
  static const defaultWindow = Duration(minutes: 10);

  static bool call(
    List<SecurityAuditLogEntity> logs,
    DateTime now, {
    int threshold = defaultThreshold,
    Duration window = defaultWindow,
  }) {
    final since = now.subtract(window);
    final recentExports = logs.where((log) =>
        log.actionType == SecurityAuditActionType.dataExport &&
        log.occurredAt.isAfter(since));
    return recentExports.length >= threshold;
  }
}
