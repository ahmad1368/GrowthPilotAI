import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_fee_waiver_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_order_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_promo_banner.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_report_summary.dart';

/// Renders the promo banner, per-order commission outcomes, a
/// reporting summary, and a narrative (Issue #420). Purely
/// presentational.
class FeeWaiverView extends StatelessWidget {
  final List<WholesaleOrderEntity> orders;
  final List<FeeWaiverRecordEntity> records;
  final bool showPromoBanner;
  final void Function(WholesaleOrderEntity) onEvaluate;

  const FeeWaiverView({
    super.key,
    required this.orders,
    required this.records,
    required this.showPromoBanner,
    required this.onEvaluate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showPromoBanner) const FeeWaiverPromoBanner(),
        for (final order in orders)
          FeeWaiverOrderRow(
            order: order,
            record: records.where((r) => r.orderId == order.id).firstOrNull,
            onEvaluate: () => onEvaluate(order),
          ),
        const SizedBox(height: 8),
        FeeWaiverReportSummary(records: records),
        const SizedBox(height: 4),
        Text(BuildFeeWaiverNarrative.call(records)),
      ],
    );
  }
}
