import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/search_audit_logs.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_view.dart';

/// Owns the filter query for the read-only audit trail (Issue #343) —
/// unlike the other admin panel tiles this has no add/edit action, since
/// entries are written by the admin flows being audited, not by this
/// widget.
class AuditTrailBody extends StatefulWidget {
  final List<AuditLogEntity> logs;

  const AuditTrailBody({super.key, required this.logs});

  @override
  State<AuditTrailBody> createState() => _AuditTrailBodyState();
}

class _AuditTrailBodyState extends State<AuditTrailBody> {
  String _adminQuery = '';
  String _merchantQuery = '';

  @override
  Widget build(BuildContext context) {
    final allResults = SearchAuditLogs.call(widget.logs, '', '');
    final filteredResults = SearchAuditLogs.call(widget.logs, _adminQuery, _merchantQuery);
    return AuditTrailView(
      filteredResults: filteredResults,
      allResults: allResults,
      onAdminFilterChanged: (q) => setState(() => _adminQuery = q),
      onMerchantFilterChanged: (q) => setState(() => _merchantQuery = q),
    );
  }
}
