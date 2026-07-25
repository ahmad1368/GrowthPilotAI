import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_supplier_scorecards.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_row.dart';

/// Registers the Supplier Price & Quality Scoring widget (Issue #369) as a
/// pluggable report widget under id `SUPPLIER_SCORECARD` (#111): vendors
/// ranked by average spend per transaction, cheapest first, with the top
/// pick starred as recommended for the next order.
class SupplierScorecardReportWidget extends BaseReportWidget {
  const SupplierScorecardReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeSupplierScorecards.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('No vendor-tagged expenses yet.');
    }
    final maxSpend =
        items.map((i) => i.totalSpend).reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items) SupplierScorecardRow(item: item, maxSpend: maxSpend),
      ],
    );
  }
}
