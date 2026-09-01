import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "A 'Warning Section' that appears only if coverage is below 100%,
/// listing exactly which goals are missing technical requirements"
/// (Issue #243).
class UncoveredGoalsWarning extends StatelessWidget {
  final List<BusinessGoalEntity> uncoveredGoals;

  const UncoveredGoalsWarning({super.key, required this.uncoveredGoals});

  @override
  Widget build(BuildContext context) {
    if (uncoveredGoals.isEmpty) return const SizedBox.shrink();
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Goals missing requirements', style: TextStyle(color: Colors.orange, fontSize: 12)),
          for (final goal in uncoveredGoals)
            Text('- ${goal.title}', style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
        ],
      ),
    );
  }
}
