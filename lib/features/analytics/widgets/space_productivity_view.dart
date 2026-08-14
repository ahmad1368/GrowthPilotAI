import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/space_productivity_result.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_stat_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the space-productivity index + a floor-space quick-edit button
/// (Issue #398). Purely presentational — [SpaceProductivityBody] owns the
/// square-footage state.
class SpaceProductivityView extends StatelessWidget {
  final SpaceProductivityResult result;
  final VoidCallback onEditSquareFootage;

  const SpaceProductivityView(
      {super.key, required this.result, required this.onEditSquareFootage});

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
              child: Text('Revenue per square foot of floor space',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onEditSquareFootage,
              child: Text('Set Sq Ft', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (!result.hasSquareFootage)
          const Text('Set your store\'s square footage to see this index.')
        else ...[
          SpaceProductivityBadge(result: result),
          const SizedBox(height: 8),
          FinancialHealthStatRow(
              label: 'Floor Space', value: '${result.squareFootage.toStringAsFixed(0)} sq ft'),
        ],
      ],
    );
  }
}
