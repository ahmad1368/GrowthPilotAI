import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_body.dart';

/// Registers the Enterprise Multi-Merchant Supervisory Master Dashboard
/// (Issue #400) as a pluggable report widget under id
/// `MULTI_MERCHANT_MASTER_DASHBOARD` (#111).
class MerchantBranchReportWidget extends BaseReportWidget {
  const MerchantBranchReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MerchantBranchBody(
      initialBranches: data['branches'] as List<MerchantBranchEntity>,
    );
  }
}
