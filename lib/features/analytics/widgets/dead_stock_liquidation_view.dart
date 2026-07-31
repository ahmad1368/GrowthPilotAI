import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';

/// Renders the period picker, capital-recovery summary, and per-item
/// liquidation rows (Issue #370).
class DeadStockLiquidationView extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onPeriodChanged;
  final List<DeadStockLiquidationSnapshot> snapshots;

  const DeadStockLiquidationView({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
    final tiedUpCapital =
        snapshots.fold<double>(0, (sum, s) => sum + s.tiedUpCapital);
    final recoverableCapital =
        snapshots.fold<double>(0, (sum, s) => sum + s.recoverableCapital);
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
            '${snapshots.length} dead-stock items · '
            '${CurrencyFormat.cad(tiedUpCapital)} tied up · '
            '${CurrencyFormat.cad(recoverableCapital)} recoverable at clearance',
            style: TextStyle(
                fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
        if (snapshots.isEmpty)
          const Text('No dead stock in the selected period.')
        else
          for (final snapshot in snapshots)
            DeadStockLiquidationRow(snapshot: snapshot),
      ],
    );
  }
}
