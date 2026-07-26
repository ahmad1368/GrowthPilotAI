import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One purchase-order row (Issue #443): summary, estimated total, and a
/// "Mark Sent" action for drafts.
class PurchaseOrderRow extends StatelessWidget {
  final PurchaseOrderEntity order;
  final VoidCallback onMarkSent;

  const PurchaseOrderRow({super.key, required this.order, required this.onMarkSent});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSent = order.status == PurchaseOrderStatus.sent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    order.vendorName.isEmpty
                        ? order.itemsSummary
                        : '${order.vendorName}: ${order.itemsSummary}',
                    overflow: TextOverflow.ellipsis),
                Text(CurrencyFormat.cad(order.estimatedTotal),
                    style: TextStyle(
                        fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
          if (isSent)
            Text('Sent',
                style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w600))
          else
            ShadButton.ghost(
              onPressed: onMarkSent,
              child: Text('Mark Sent', style: TextStyle(color: scheme.onSurface)),
            ),
        ],
      ),
    );
  }
}
