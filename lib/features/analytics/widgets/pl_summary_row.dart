import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/pl_summary.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Income / Expense / Net Profit stat row for the P&L widget (Issue #355).
/// Net profit turns the theme's error color when negative.
class PLSummaryRow extends StatelessWidget {
  final PLSummary summary;

  const PLSummaryRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final netColor = summary.netProfit < 0 ? scheme.error : scheme.primary;
    return Row(
      children: [
        _stat(context, 'Income', summary.totalIncome, scheme.onSurface),
        _stat(context, 'Expenses', summary.totalExpense, scheme.onSurface),
        _stat(context, 'Net Profit', summary.netProfit, netColor),
      ],
    );
  }

  Widget _stat(BuildContext context, String label, double value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          Text(CurrencyFormat.cad(value),
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
