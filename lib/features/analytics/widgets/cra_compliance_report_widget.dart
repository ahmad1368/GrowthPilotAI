import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_body.dart';

/// Registers Comprehensive Banking and Crypto Transaction Logging
/// with CRA Tax Compliance (Issue #428) as a pluggable report widget
/// under id `CRA_COMPLIANCE_LOGGING_ENGINE` (#111) — no external data
/// needed; [CraComplianceBody] reads existing gateway transactions
/// (#421-423) and its own compliance ledger itself.
class CraComplianceReportWidget extends BaseReportWidget {
  const CraComplianceReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const CraComplianceBody();
  }
}
