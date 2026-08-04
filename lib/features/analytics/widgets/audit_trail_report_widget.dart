import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_body.dart';

/// Registers the Comprehensive Audit Trail & Activity Logging Panel
/// (Issue #343) as a pluggable report widget under id
/// `AUDIT_TRAIL_PANEL` (#111).
class AuditTrailReportWidget extends BaseReportWidget {
  const AuditTrailReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AuditTrailBody(logs: data['logs'] as List<AuditLogEntity>);
  }
}
