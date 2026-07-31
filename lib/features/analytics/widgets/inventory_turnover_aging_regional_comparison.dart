import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/get_regional_turnover_benchmark.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

/// Compares this store's average turnover against its Vancouver sector peers
/// (Issue #447).
class InventoryTurnoverAgingRegionalComparison extends StatelessWidget {
  final BusinessSector sector;
  final double averageTurnover;

  const InventoryTurnoverAgingRegionalComparison(
      {super.key, required this.sector, required this.averageTurnover});

  @override
  Widget build(BuildContext context) {
    final benchmark = GetRegionalTurnoverBenchmark.call(sector);
    final scheme = Theme.of(context).colorScheme;
    final aboveBenchmark = averageTurnover >= benchmark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'Your average ${averageTurnover.toStringAsFixed(2)}x vs '
        '${sector.name} sector average ${benchmark.toStringAsFixed(2)}x',
        style: TextStyle(
          fontSize: 12,
          color: aboveBenchmark ? scheme.primary : scheme.error,
        ),
      ),
    );
  }
}
