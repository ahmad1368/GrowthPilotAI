import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_staff_efficiency_narrative.dart';
import 'package:growth_pilot_ai/core/models/staff_efficiency.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_efficiency_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-shift efficiency rows, a quick-add button, and a summary
/// narrative (Issue #379). Purely presentational — the shift list is
/// owned by [StaffEfficiencyBody].
class StaffEfficiencyView extends StatelessWidget {
  final List<StaffEfficiency> results;
  final VoidCallback onAddShift;

  const StaffEfficiencyView(
      {super.key, required this.results, required this.onAddShift});

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
              onPressed: onAddShift,
              child: Text('+ Log Shift', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) StaffEfficiencyRow(result: result),
        const SizedBox(height: 8),
        Text(BuildStaffEfficiencyNarrative.call(results)),
      ],
    );
  }
}
