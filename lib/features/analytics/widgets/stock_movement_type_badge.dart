import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Direction badge for a stock movement (Issue #439). Always pairs color
/// with an icon + label so direction reads for color-blind users.
class StockMovementTypeBadge extends StatelessWidget {
  final StockMovementType type;

  const StockMovementTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isSale = type == StockMovementType.sale;
    final color = isSale ? Colors.red : Colors.green;
    final icon = isSale ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    final label = isSale ? 'Sale' : 'Return';

    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ]),
    );
  }
}
