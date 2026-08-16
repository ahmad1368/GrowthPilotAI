import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';
import 'package:growth_pilot_ai/features/insights/widgets/action_impact_status_chip.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One roadmap row (Issue #260's ActionCard) — flat card, not the issue's
/// literal glassmorphism treatment (architecture forbids Glassmorphism/
/// BackdropFilter).
class ActionImpactCard extends StatelessWidget {
  final ActionImpactItem item;

  const ActionImpactCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Text(item.title,
                style: TextStyle(color: colors.foreground, fontSize: 14)),
          ),
          const SizedBox(width: 8),
          ActionImpactStatusChip(status: item.status),
        ],
      ),
    );
  }
}
