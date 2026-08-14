import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/core/models/inventory_turnover_and_aging_snapshot.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_regional_comparison.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_row.dart';

/// Renders the period picker, regional comparison, and per-item rows
/// (Issue #447).
class InventoryTurnoverAgingView extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onPeriodChanged;
  final BusinessSector sector;
  final double averageTurnover;
  final List<InventoryTurnoverAndAgingSnapshot> snapshots;

  const InventoryTurnoverAgingView({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.sector,
    required this.averageTurnover,
    required this.snapshots,
  });

  @override
  Widget build(BuildContext context) {
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
        InventoryTurnoverAgingRegionalComparison(
            sector: sector, averageTurnover: averageTurnover),
        if (snapshots.isEmpty)
          const Text('No inventory data yet.')
        else
          for (final snapshot in snapshots)
            InventoryTurnoverAgingRow(snapshot: snapshot),
      ],
    );
  }
}
