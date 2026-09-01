import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/simulate_inflation_impact.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inflation_scenario_row.dart';

/// Registers the Local Inflation Comparative Reporting widget (Issue #373)
/// as a pluggable report widget under id `INFLATION_IMPACT` (#111):
/// simulates margin impact of a static reference inflation rate under
/// absorb-vs-pass-through pricing strategies.
class InflationImpactReportWidget extends BaseReportWidget {
  const InflationImpactReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final scenarios = SimulateInflationImpact.call(
        data['transactions'] as List<TransactionEntity>);
    if (scenarios.isEmpty) {
      return const Text('Not enough transaction data to simulate yet.');
    }
    final scheme = Theme.of(context).colorScheme;
    final baseline = scenarios.first.projectedMarginPercent;
    final ratePercent =
        (SimulateInflationImpact.referenceInflationRate * 100).toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference rate: $ratePercent% (static illustrative figure, not a live index)',
          style: TextStyle(
              fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 8),
        for (final s in scenarios)
          InflationScenarioRow(scenario: s, baselineMargin: baseline),
      ],
    );
  }
}
