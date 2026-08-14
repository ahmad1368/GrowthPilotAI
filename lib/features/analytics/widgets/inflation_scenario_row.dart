import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inflation_impact_scenario.dart';

/// One scenario row in the inflation-impact simulator (Issue #373): the
/// projected margin, colored error when it's worse than the current
/// baseline margin.
class InflationScenarioRow extends StatelessWidget {
  final InflationImpactScenario scenario;
  final double baselineMargin;

  const InflationScenarioRow(
      {super.key, required this.scenario, required this.baselineMargin});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isWorse = scenario.projectedMarginPercent < baselineMargin - 0.01;
    final color = isWorse ? scheme.error : scheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(scenario.scenarioName, overflow: TextOverflow.ellipsis),
          ),
          Text(
            '${scenario.projectedMarginPercent.toStringAsFixed(1)}%',
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
