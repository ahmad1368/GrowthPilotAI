import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_cash_flow_forecast.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_forecast_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_forecast_summary_header.dart';

/// Registers the Historical Cash Flow Forecasting widget (Issue #368) as a
/// pluggable report widget under id `CASH_FLOW_FORECAST` (#111): monthly
/// income/expense projected 3 months ahead via linear regression, flagging
/// any projected deficit month.
class CashFlowForecastReportWidget extends BaseReportWidget {
  const CashFlowForecastReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeCashFlowForecast.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('Not enough transaction history to forecast yet.');
    }
    final maxAbs =
        items.map((i) => i.projectedNet.abs()).reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CashFlowForecastSummaryHeader(projections: items),
        for (final item in items) CashFlowForecastRow(item: item, maxAbs: maxAbs),
      ],
    );
  }
}
