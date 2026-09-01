import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_annual_profit_forecast.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_stat_row.dart';

/// Registers the Comprehensive Annual Profit Forecast widget (Issue #399)
/// as a pluggable report widget under id `ANNUAL_PROFIT_FORECAST` (#111):
/// a 12-month profit projection with best/expected/worst-case bands.
class AnnualProfitForecastReportWidget extends BaseReportWidget {
  const AnnualProfitForecastReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final forecast = ComputeAnnualProfitForecast.call(
        data['transactions'] as List<TransactionEntity>);
    if (forecast == null) {
      return const Text('Not enough transaction history to forecast yet.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialHealthStatRow(
            label: 'Best Case', value: CurrencyFormat.cad(forecast.bestCaseAnnualProfit)),
        FinancialHealthStatRow(
            label: 'Expected', value: CurrencyFormat.cad(forecast.expectedAnnualProfit)),
        FinancialHealthStatRow(
            label: 'Worst Case', value: CurrencyFormat.cad(forecast.worstCaseAnnualProfit)),
        const SizedBox(height: 8),
        Text('Projected to peak in ${forecast.peakMonthLabel}.',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8))),
      ],
    );
  }
}
