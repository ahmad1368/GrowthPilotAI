import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_commission_tier_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One marketplace order with its tiered-commission settlement
/// outcome (Issue #425, acceptance criteria 1-2) — mirrors
/// [FeeWaiverOrderRow] (#420): an unsettled order shows a "Settle"
/// action; a settled one shows the applied tier and rate.
class TieredCommissionOrderRow extends StatelessWidget {
  final WholesaleOrderEntity order;
  final CommissionTierRecordEntity? record;
  final VoidCallback onSettle;

  const TieredCommissionOrderRow({
    super.key,
    required this.order,
    required this.record,
    required this.onSettle,
  });

  @override
  Widget build(BuildContext context) {
    final r = record;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Expanded(
          child: Text(
            r == null
                ? '${order.buyerMerchantName}: \$${order.totalAmount.toStringAsFixed(2)} — not yet settled'
                : BuildCommissionTierNarrative.call(r),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        if (r == null) ShadButton.ghost(onPressed: onSettle, child: const Text('Settle')),
      ]),
    );
  }
}
