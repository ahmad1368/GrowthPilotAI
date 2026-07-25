import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_waste_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_reason_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the waste-log total + reason rows + a quick-add button (Issue
/// #377). Purely presentational — [WasteLogBody] owns the entry list.
class WasteSummaryView extends StatelessWidget {
  final List<WasteLogEntity> entries;
  final VoidCallback onAddEntry;

  const WasteSummaryView({super.key, required this.entries, required this.onAddEntry});

  @override
  Widget build(BuildContext context) {
    final summary = ComputeWasteSummary.call(entries);
    final totalLoss = summary.fold(0.0, (sum, s) => sum + s.totalValue);
    final maxValue = summary.isEmpty
        ? 0.0
        : summary.map((s) => s.totalValue).reduce((a, b) => a > b ? a : b);
    final fg = Theme.of(context).colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Total loss: ${CurrencyFormat.cad(totalLoss)}',
                  overflow: TextOverflow.ellipsis),
            ),
            ShadButton.outline(
              onPressed: onAddEntry,
              child: Text('+ Log Waste', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (summary.isEmpty)
          const Text('No waste logged yet.')
        else
          for (final s in summary) WasteReasonRow(item: s, maxValue: maxValue),
      ],
    );
  }
}
