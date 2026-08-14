import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_adjustment_impacts.dart';
import 'package:growth_pilot_ai/business/group_impacts_by_month.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/impact_analysis_view.dart';

/// Computes the profitability impact read from the audit trail (Issue
/// #349) — read-only, so there's no local state to own beyond the
/// derived computation itself.
class ImpactAnalysisBody extends StatelessWidget {
  final List<AuditLogEntity> auditLogs;

  const ImpactAnalysisBody({super.key, required this.auditLogs});

  @override
  Widget build(BuildContext context) {
    final impacts = ComputeAdjustmentImpacts.call(auditLogs);
    final monthlyPoints = GroupImpactsByMonth.call(impacts);
    return ImpactAnalysisView(impacts: impacts, monthlyPoints: monthlyPoints);
  }
}
