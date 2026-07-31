import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';

/// One item's projected stock-out ETA (Issue #360).
class StockDepletionForecastRow extends StatelessWidget {
  final StockDepletionForecast forecast;

  const StockDepletionForecastRow({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final days = forecast.daysUntilStockout;
    final label = days == null ? 'No recent sales' : '${days.ceil()}d left';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(forecast.item.name, overflow: TextOverflow.ellipsis)),
          Text('${forecast.item.quantityOnHand} on hand',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: forecast.isCritical ? scheme.error : scheme.onSurface)),
        ],
      ),
    );
  }
}
