import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_multi_merchant_narrative.dart';
import 'package:growth_pilot_ai/core/models/branch_performance_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-branch drill-down rows, a quick-add button, and a summary
/// narrative (Issue #400). Purely presentational — the branch list is
/// owned by [MerchantBranchBody].
class MerchantBranchView extends StatelessWidget {
  final List<BranchPerformanceSummary> results;
  final VoidCallback onAddBranch;

  const MerchantBranchView(
      {super.key, required this.results, required this.onAddBranch});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddBranch,
              child: Text('+ Log Branch', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) MerchantBranchRow(result: result),
        const SizedBox(height: 8),
        Text(BuildMultiMerchantNarrative.call(results)),
      ],
    );
  }
}
