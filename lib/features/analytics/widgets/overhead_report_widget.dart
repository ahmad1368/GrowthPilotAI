import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_overhead_breakdown.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_category_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_summary_header.dart';

/// Registers the Operating Expense & Overhead Analysis widget (Issue #367)
/// as a pluggable report widget under id `OVERHEAD_ANALYSIS` (#111):
/// expense categories ranked by their share of total revenue, with a
/// budget-variance warning past [ComputeOverheadBreakdown.alertThreshold].
class OverheadReportWidget extends BaseReportWidget {
  const OverheadReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeOverheadBreakdown.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('No expense transactions yet.');
    }
    final totalRatio = items.fold(0.0, (sum, i) => sum + i.ratioToRevenue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OverheadSummaryHeader(totalRatio: totalRatio),
        for (final item in items) OverheadCategoryRow(item: item),
      ],
    );
  }
}
