import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_stock_depletion_forecast.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_view.dart';

/// State for [StockDepletionForecastBody] (Issue #360): recomputes the
/// stock-out forecast for the selected period.
class StockDepletionForecastBodyState extends State<StockDepletionForecastBody> {
  TurnoverPeriod _period = TurnoverPeriod.last30;

  @override
  Widget build(BuildContext context) {
    final forecasts = ComputeStockDepletionForecast.call(
      widget.items,
      widget.movements,
      DateTime.now(),
      _period.duration,
    );

    return StockDepletionForecastView(
      period: _period,
      onPeriodChanged: (p) => setState(() => _period = p ?? _period),
      forecasts: forecasts,
    );
  }
}
