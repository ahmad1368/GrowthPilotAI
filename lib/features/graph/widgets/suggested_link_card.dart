import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/suggested_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "One-Tap Approval: the user sees an AI-suggested link with a
/// 'Magic Wand' icon... tapping shows the AI Reasoning" (Issue #244).
class SuggestedLinkCard extends StatelessWidget {
  final SuggestedLinkEntity suggestion;
  final BusinessGoalEntity goal;
  final TraceableRequirementEntity requirement;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const SuggestedLinkCard({
    super.key,
    required this.suggestion,
    required this.goal,
    required this.requirement,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_fix_high, size: 14, color: Colors.purple),
              const SizedBox(width: 6),
              Expanded(
                child: Text('${goal.title}  ->  ${requirement.reqCode} ${requirement.description}',
                    style: TextStyle(color: colors.foreground, fontSize: 13)),
              ),
              Text('${(suggestion.confidenceScore * 100).round()}%',
                  style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
            ],
          ),
          Text(suggestion.reasoning, style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
          Row(
            children: [
              ShadButton(onPressed: onApprove, child: const Text('Approve')),
              const SizedBox(width: 8),
              ShadButton.outline(onPressed: onReject, child: const Text('Reject')),
            ],
          ),
        ],
      ),
    );
  }
}
