import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_body.dart';

/// Registers the Local Legal & Compliance Risk widget (Issue #392) as a
/// pluggable report widget under id `COMPLIANCE_RISK` (#111).
class ComplianceRiskReportWidget extends BaseReportWidget {
  const ComplianceRiskReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ComplianceRiskBody(
      initialItems: data['items'] as List<ComplianceItemEntity>,
    );
  }
}
