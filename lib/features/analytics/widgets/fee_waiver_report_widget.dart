import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_body.dart';

/// Registers the Zero-Commission Incentive for Initial Successful
/// Marketplace Transactions (Issue #420) as a pluggable report widget
/// under id `FEE_WAIVER_INCENTIVE` (#111) — no external data needed;
/// [FeeWaiverBody] reads existing wholesale orders (#411) itself.
class FeeWaiverReportWidget extends BaseReportWidget {
  const FeeWaiverReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const FeeWaiverBody();
  }
}
