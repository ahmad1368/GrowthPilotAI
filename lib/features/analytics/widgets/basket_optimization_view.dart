import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/basket_optimization_snapshot.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';

/// Renders the period picker, capital-exposure summary, and per-item
/// optimization rows (Issue #390).
class BasketOptimizationView extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onPeriodChanged;
  final List<BasketOptimizationSnapshot> snapshots;

  const BasketOptimizationView({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
    final holdingCostExposure =
        snapshots.fold<double>(0, (sum, s) => sum + s.holdingCostExposure);
    final reorderCount =
        snapshots.where((s) => s.shortfallQuantity > 0).length;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InventoryTurnoverAgingPeriodSelect(
                period: period, onChanged: onPeriodChanged),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '$reorderCount items to reorder · '
            '${CurrencyFormat.cad(holdingCostExposure)} tied up in excess stock',
            style: TextStyle(
                fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
        if (snapshots.isEmpty)
          const Text('No inventory items in the selected period.')
        else
          for (final snapshot in snapshots)
            BasketOptimizationRow(snapshot: snapshot),
      ],
    );
  }
}
