import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_type_badge.dart';

/// One stock-movement row (Issue #439): item, direction badge, quantity
/// change, and the resulting quantity on hand.
class StockMovementRow extends StatelessWidget {
  final StockMovementEntity movement;

  const StockMovementRow({super.key, required this.movement});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sign = movement.type == StockMovementType.sale ? '-' : '+';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movement.itemName, overflow: TextOverflow.ellipsis),
                Text(movement.channel == SalesChannel.pos ? 'In-Store (POS)' : 'Online',
                    style:
                        TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.5))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StockMovementTypeBadge(type: movement.type),
              Text('$sign${movement.quantity}  (now ${movement.resultingQuantityOnHand})',
                  style:
                      TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
        ],
      ),
    );
  }
}
