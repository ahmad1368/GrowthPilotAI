import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

/// One-sentence read naming the most recent audited change (Issue
/// #343).
class BuildAuditTrailNarrative {
  static String call(List<AuditLogEntity> results) {
    if (results.isEmpty) {
      return 'No audited changes yet — admin actions on merchant profiles will appear here.';
    }
    final latest = results.first;
    return '${results.length} change(s) logged — most recently ${latest.adminId} '
        '${latest.changeType} on ${latest.targetMerchant}.';
  }
}
