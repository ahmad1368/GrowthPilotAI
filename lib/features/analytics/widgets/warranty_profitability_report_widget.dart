import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_profitability_body.dart';

/// Registers the After-Sales Service & Warranty Profitability Evaluator
/// (Issue #389) as a pluggable report widget under id
/// `WARRANTY_PROFITABILITY` (#111).
class WarrantyProfitabilityReportWidget extends BaseReportWidget {
  const WarrantyProfitabilityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return WarrantyProfitabilityBody(
      initialClaims: data['claims'] as List<WarrantyClaimEntity>,
    );
  }
}
