import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_pl_summary.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_period_chips.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_category_tile.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_summary_row.dart';

/// Body of the Itemized Financial Reporting / P&L widget (Issue #355): a
/// local Monthly/Quarterly/Annual toggle (reusing #84's [CompassPeriod] +
/// [FilterTransactionsByPeriod]) drives [ComputePLSummary] on-device.
class PLReportBody extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const PLReportBody({super.key, required this.transactions});

  @override
  State<PLReportBody> createState() => _PLReportBodyState();
}

class _PLReportBodyState extends State<PLReportBody> {
  var _period = CompassPeriod.monthly;

  @override
  Widget build(BuildContext context) {
    final windowed = FilterTransactionsByPeriod.call(
        widget.transactions, _period, DateTime.now());
    final summary = ComputePLSummary.call(windowed);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompassPeriodChips(
          selected: _period,
          onChanged: (p) => setState(() => _period = p),
        ),
        const SizedBox(height: 12),
        PLSummaryRow(summary: summary),
        const SizedBox(height: 8),
        for (final breakdown in summary.expenseByCategory)
          PLCategoryTile(breakdown: breakdown),
      ],
    );
  }
}
