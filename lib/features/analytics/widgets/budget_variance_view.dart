import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/budget_variance.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the budget-variance rows + a quick-configure button (Issue
/// #383). Purely presentational — [BudgetVarianceBody] owns the state.
class BudgetVarianceView extends StatelessWidget {
  final List<BudgetVariance> variances;
  final VoidCallback onSetLimit;

  const BudgetVarianceView({super.key, required this.variances, required this.onSetLimit});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Trailing 30 days vs. configured limits',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onSetLimit,
              child: Text('+ Set Limit', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (variances.isEmpty)
          const Text('No budget limits configured yet.')
        else
          for (final v in variances) BudgetVarianceRow(item: v),
      ],
    );
  }
}
