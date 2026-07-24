import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart_body.dart';

/// Registers the Profit Margin Analysis widget (Issue #350) as a pluggable
/// report widget under id `PROFIT_MARGIN_CHART` (#111).
class ProfitMarginReportWidget extends BaseReportWidget {
  const ProfitMarginReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ProfitMarginChartBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
