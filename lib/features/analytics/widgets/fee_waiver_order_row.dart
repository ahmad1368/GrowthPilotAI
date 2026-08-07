import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One marketplace order with its commission/waiver outcome (Issue
/// #420, acceptance criteria 1-2) — an unevaluated order shows an
/// "Evaluate" action; an evaluated one just shows the outcome.
class FeeWaiverOrderRow extends StatelessWidget {
  final WholesaleOrderEntity order;
  final FeeWaiverRecordEntity? record;
  final VoidCallback onEvaluate;

  const FeeWaiverOrderRow({super.key, required this.order, required this.record, required this.onEvaluate});

  @override
  Widget build(BuildContext context) {
    final r = record;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Expanded(
          child: Text(
              r == null
                  ? '${order.buyerMerchantName}: \$${order.totalAmount.toStringAsFixed(2)} — not yet evaluated'
                  : '${order.buyerMerchantName}: \$${order.totalAmount.toStringAsFixed(2)} — '
                      '${r.isWaived ? 'commission waived (\$${r.waivedAmount.toStringAsFixed(2)})' : 'commission \$${r.commissionAmount.toStringAsFixed(2)}'}',
              style: const TextStyle(fontSize: 12)),
        ),
        if (r == null) ShadButton.ghost(onPressed: onEvaluate, child: const Text('Evaluate')),
      ]),
    );
  }
}
