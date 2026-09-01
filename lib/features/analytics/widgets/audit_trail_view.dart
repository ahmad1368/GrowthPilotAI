import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_audit_trail_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_filter_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_row.dart';

/// Renders the search filters, filtered read-only rows, and a summary
/// narrative (Issue #343). Purely presentational — the log list and
/// filter state are owned by [AuditTrailBody].
class AuditTrailView extends StatelessWidget {
  final List<AuditLogEntity> filteredResults;
  final List<AuditLogEntity> allResults;
  final ValueChanged<String> onAdminFilterChanged;
  final ValueChanged<String> onMerchantFilterChanged;

  const AuditTrailView({
    super.key,
    required this.filteredResults,
    required this.allResults,
    required this.onAdminFilterChanged,
    required this.onMerchantFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuditTrailFilterFields(
          onAdminChanged: onAdminFilterChanged,
          onMerchantChanged: onMerchantFilterChanged,
        ),
        const SizedBox(height: 8),
        for (final entry in filteredResults) AuditTrailRow(entry: entry),
        const SizedBox(height: 8),
        Text(BuildAuditTrailNarrative.call(allResults)),
      ],
    );
  }
}
