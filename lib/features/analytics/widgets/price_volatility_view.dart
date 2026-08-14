import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_price_volatility_narrative.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_threshold_field.dart';

/// Renders the threshold field, comparative volatility chart, per-product
/// rows, and a summary narrative (Issue #340). Purely presentational —
/// the observation list and threshold are owned by
/// [PriceVolatilityBody].
class PriceVolatilityView extends StatelessWidget {
  final List<PriceVolatilityAlert> results;
  final double thresholdPercent;
  final ValueChanged<double> onThresholdSaved;

  const PriceVolatilityView({
    super.key,
    required this.results,
    required this.thresholdPercent,
    required this.onThresholdSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PriceVolatilityThresholdField(
            thresholdPercent: thresholdPercent, onSaved: onThresholdSaved),
        const SizedBox(height: 8),
        if (results.isNotEmpty) PriceVolatilityChart(results: results),
        const SizedBox(height: 8),
        for (final result in results) PriceVolatilityRow(result: result),
        const SizedBox(height: 8),
        Text(BuildPriceVolatilityNarrative.call(results)),
      ],
    );
  }
}
