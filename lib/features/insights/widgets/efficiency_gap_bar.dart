import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/efficiency_gap_status.dart';
import 'package:growth_pilot_ai/features/insights/widgets/efficiency_status_pill.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Efficiency Gap" visualizer (Issue #100) — a flat progress bar, not
/// the issue's literal Glassmorphism/frosted-glass ask (architecture
/// forbids Glassmorphism/BackdropFilter).
class EfficiencyGapBar extends StatelessWidget {
  final int score;
  final EfficiencyGapStatus status;
  final String? insight;

  const EfficiencyGapBar({super.key, required this.score, required this.status, this.insight});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Efficiency Score', style: TextStyle(color: colors.foreground, fontSize: 13)),
          EfficiencyStatusPill(status: status),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 8,
              backgroundColor: colors.border,
              color: colors.primary),
        ),
        if (insight != null) ...[
          const SizedBox(height: 8),
          Text(insight!, style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
        ],
      ]),
    );
  }
}
