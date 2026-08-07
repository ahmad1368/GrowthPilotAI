import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_row.dart';

/// Admin oversight drill-down into one transaction's state history
/// (Issue #426, acceptance criterion 5) — reuses [AuditTrailRow]
/// (#343) rather than a new read-only row layout.
class SettlementTrackingHistoryPanel extends StatelessWidget {
  final List<AuditLogEntity> history;

  const SettlementTrackingHistoryPanel({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return const SizedBox.shrink();
    return ExpansionTile(
      title: Text('History (${history.length})', style: const TextStyle(fontSize: 11)),
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      children: [for (final entry in history) AuditTrailRow(entry: entry)],
    );
  }
}
