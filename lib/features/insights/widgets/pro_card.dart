import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/pro_card_insight.dart';
import 'package:growth_pilot_ai/features/insights/widgets/pro_card_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Like the Pros" card (Issue #85) — flat, amber-accented, not the
/// issue's literal Glassmorphism "Pro Gold glow". Always carries the
/// CPABC-required disclaimer.
class ProCard extends StatelessWidget {
  final ProCardInsight insight;
  final bool isProcessing;
  final VoidCallback onAct;
  final VoidCallback onSave;
  final VoidCallback onDismiss;

  const ProCard({
    super.key,
    required this.insight,
    required this.isProcessing,
    required this.onAct,
    required this.onSave,
    required this.onDismiss,
  });
  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final decoration = BoxDecoration(
        color: colors.card, border: Border.all(color: Colors.amber, width: 1.5), borderRadius: BorderRadius.circular(8));
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: decoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Strategy: Like the Pros',
            style: TextStyle(color: Colors.amber.shade800, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(insight.insightText, style: TextStyle(color: colors.foreground, fontSize: 13)),
        const SizedBox(height: 4),
        Text('Data-driven observation, not professional accounting advice.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
        const SizedBox(height: 8),
        ProCardActions(
            actionLabel: insight.actionLabel,
            isProcessing: isProcessing,
            onAct: onAct,
            onSave: onSave,
            onDismiss: onDismiss),
      ]),
    );
  }
}
