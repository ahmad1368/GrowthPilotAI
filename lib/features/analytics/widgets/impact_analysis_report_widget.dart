import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/impact_analysis_body.dart';

/// Registers the Real-Time Impact Analysis & Profitability Reporting
/// Dashboard (Issue #349) as a pluggable report widget under id
/// `IMPACT_ANALYSIS_DASHBOARD` (#111).
class ImpactAnalysisReportWidget extends BaseReportWidget {
  const ImpactAnalysisReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ImpactAnalysisBody(auditLogs: data['logs'] as List<AuditLogEntity>);
  }
}
