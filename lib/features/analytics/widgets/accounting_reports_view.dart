import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/accounting_reports_export_button.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/accounting_reports_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the exportable per-merchant accounting summary (Issue
/// #427, acceptance criterion 1). Purely presentational.
class AccountingReportsView extends StatelessWidget {
  final List<MerchantAccountingSummary> summaries;
  final VoidCallback onRefresh;

  const AccountingReportsView({super.key, required this.summaries, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (summaries.isEmpty) {
      return const Text(
        'No fee, waiver, or settlement activity yet — bookkeeping totals '
        'will appear here once transactions are processed.',
        style: TextStyle(fontSize: 12),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.ghost(onPressed: onRefresh, child: const Text('Refresh')),
          AccountingReportsExportButton(summaries: summaries),
        ]),
        for (final summary in summaries) AccountingReportsRow(summary: summary),
      ],
    );
  }
}
