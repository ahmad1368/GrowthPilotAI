import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_order_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_summary_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_view_state.dart';

/// Renders per-order settlement rows plus a per-merchant revenue and
/// override summary (Issue #425, acceptance criteria 1-3 and 5).
/// Purely presentational.
class TieredCommissionView extends StatelessWidget {
  final TieredCommissionViewState state;
  final void Function(WholesaleOrderEntity) onSettle;
  final void Function(String, CommissionTierBand) onSetOverride;
  final void Function(String) onClearOverride;

  const TieredCommissionView({
    super.key,
    required this.state,
    required this.onSettle,
    required this.onSetOverride,
    required this.onClearOverride,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final order in state.orders)
          TieredCommissionOrderRow(
            order: order,
            record: state.records.where((r) => r.orderId == order.id).firstOrNull,
            onSettle: () => onSettle(order),
          ),
        const SizedBox(height: 8),
        Text('Revenue by merchant', style: Theme.of(context).textTheme.labelMedium),
        for (final summary in state.summaries)
          TieredCommissionSummaryRow(
            summary: summary,
            overrideBand: state.overrides[summary.merchantName],
            onSetOverride: (band) => onSetOverride(summary.merchantName, band),
            onClearOverride: () => onClearOverride(summary.merchantName),
          ),
      ],
    );
  }
}
