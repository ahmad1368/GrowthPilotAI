import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_category_profitability.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_row.dart';

/// Registers the Item/Service-Level Profitability Breakdown widget (Issue
/// #361) as a pluggable report widget under id `CATEGORY_PROFITABILITY`
/// (#111): categories ranked by net profit, top revenue driver first.
class CategoryProfitabilityReportWidget extends BaseReportWidget {
  const CategoryProfitabilityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeCategoryProfitability.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('No categorized transactions yet.');
    }
    final maxAbs =
        items.map((i) => i.netProfit.abs()).reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          CategoryProfitabilityRow(item: item, maxAbs: maxAbs),
      ],
    );
  }
}
