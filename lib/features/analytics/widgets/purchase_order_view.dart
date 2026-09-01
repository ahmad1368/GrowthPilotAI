import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders purchase-order rows + a generate-draft button (Issue #443).
/// Purely presentational — [PurchaseOrderBody] owns the order list.
class PurchaseOrderView extends StatelessWidget {
  final List<PurchaseOrderEntity> orders;
  final VoidCallback onGenerateDraft;
  final ValueChanged<PurchaseOrderEntity> onMarkSent;

  const PurchaseOrderView({
    super.key,
    required this.orders,
    required this.onGenerateDraft,
    required this.onMarkSent,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sorted = [...orders]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Auto-suggested from low-stock items',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onGenerateDraft,
              child: Text('+ Generate PO', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (sorted.isEmpty)
          const Text('No purchase orders yet.')
        else
          for (final o in sorted) PurchaseOrderRow(order: o, onMarkSent: () => onMarkSent(o)),
      ],
    );
  }
}
