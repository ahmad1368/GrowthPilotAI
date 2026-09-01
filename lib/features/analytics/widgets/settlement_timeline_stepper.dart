import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/settlement_timeline_step.dart';

/// Visual progress timeline for one settlement (Issue #426, acceptance
/// criteria 2 and 4) — a [Wrap] rather than a fixed horizontal row so
/// it reflows cleanly on narrow mobile widths without overflowing.
class SettlementTimelineStepper extends StatelessWidget {
  final List<SettlementTimelineStep> steps;

  const SettlementTimelineStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        for (final step in steps.where((s) => s.isApplicable))
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              step.isComplete
                  ? Icons.check_circle
                  : step.isCurrent
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
              size: 14,
              color: step.isComplete || step.isCurrent
                  ? scheme.primary
                  : scheme.onSurface.withValues(alpha: 0.35),
            ),
            const SizedBox(width: 4),
            Text(step.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: step.isCurrent ? FontWeight.w600 : FontWeight.normal,
                )),
          ]),
      ],
    );
  }
}
