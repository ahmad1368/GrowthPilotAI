import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/cohort_clv_comparison.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Side-by-side New-cohort vs Established-cohort average CLV bars
/// (Issue #394).
class ClvCohortComparisonBar extends StatelessWidget {
  final CohortClvComparison comparison;

  const ClvCohortComparisonBar({super.key, required this.comparison});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxClv = comparison.newCohortAverageClv > comparison.establishedCohortAverageClv
        ? comparison.newCohortAverageClv
        : comparison.establishedCohortAverageClv;

    Widget bar(String label, double value, int count) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label ($count)', style: const TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: maxClv <= 0 ? 0 : (value / maxClv).clamp(0.0, 1.0),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(CurrencyFormat.cad(value), style: const TextStyle(fontSize: 11)),
            ],
          ),
        );

    return Row(
      children: [
        bar('New', comparison.newCohortAverageClv, comparison.newCohortCount),
        const SizedBox(width: 16),
        bar('Established', comparison.establishedCohortAverageClv,
            comparison.establishedCohortCount),
      ],
    );
  }
}
