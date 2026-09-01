import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/suggested_link_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Review All Suggestions" (Issue #244) — a "Generate Suggestions"
/// trigger plus the list of pending AI-suggested links.
class SuggestionReviewSection extends StatelessWidget {
  final TraceabilityController controller;

  const SuggestionReviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadButton.outline(
            onPressed: controller.generateSuggestions,
            child: const Text('Generate AI Suggestions'),
          ),
          const SizedBox(height: 8),
          if (controller.suggestions.isEmpty)
            Text('No pending suggestions.', style: TextStyle(color: colors.mutedForeground, fontSize: 12))
          else
            for (final suggestion in controller.suggestions)
              SuggestedLinkCard(
                suggestion: suggestion,
                goal: controller.goalList.firstWhere((g) => g.id == suggestion.goal.targetId),
                requirement:
                    controller.requirementList.firstWhere((r) => r.id == suggestion.requirement.targetId),
                onApprove: () => controller.approveSuggestion(suggestion),
                onReject: () => controller.rejectSuggestion(suggestion),
              ),
        ],
      );
    });
  }
}
