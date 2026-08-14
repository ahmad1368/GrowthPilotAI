import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_stock_depletion_forecast.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_row.dart';

/// Renders the period picker, a critical-items summary, and per-item
/// stock-out forecast rows (Issue #360).
class StockDepletionForecastView extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onPeriodChanged;
  final List<StockDepletionForecast> forecasts;

  const StockDepletionForecastView({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    final criticalCount = forecasts.where((f) => f.isCritical).length;
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
            '$criticalCount items projected to run out within '
            '${ComputeStockDepletionForecast.criticalDaysThreshold} days',
            style: TextStyle(
                fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
        if (forecasts.isEmpty)
          const Text('No inventory items to forecast.')
        else
          for (final forecast in forecasts)
            StockDepletionForecastRow(forecast: forecast),
      ],
    );
  }
}
