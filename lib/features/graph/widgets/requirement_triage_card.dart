import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_card_body.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_card_header.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_triage_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One candidate requirement card (Issue #228/#229/#231): Confirm/Edit/
/// Reject + Manual Override dropdowns + batch checkbox + confidence.
/// Tapping the card selects it, highlighting its span in the source
/// document viewer. Flat, no Glassmorphism.
class RequirementTriageCard extends StatelessWidget {
  final ExtractedRequirement requirement;
  final bool isSelected;
  final bool isBatchSelected;
  final VoidCallback onTap;
  final ValueChanged<bool?> onBatchToggle;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final VoidCallback onEdit;
  final VoidCallback? onLinkToGoal;
  final ValueChanged<RequirementMoscowPriority> onPriorityChanged;
  final ValueChanged<String> onStakeholderChanged;

  const RequirementTriageCard({
    super.key,
    required this.requirement,
    required this.isSelected,
    required this.isBatchSelected,
    required this.onTap,
    required this.onBatchToggle,
    required this.onConfirm,
    required this.onReject,
    required this.onEdit,
    this.onLinkToGoal,
    required this.onPriorityChanged,
    required this.onStakeholderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? colors.primary : Colors.transparent, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequirementCardHeader(
              isBatchSelected: isBatchSelected,
              onBatchToggle: onBatchToggle,
              confidence: requirement.confidence,
            ),
            RequirementCardBody(
              requirement: requirement,
              onPriorityChanged: onPriorityChanged,
              onStakeholderChanged: onStakeholderChanged,
            ),
            const SizedBox(height: 8),
            RequirementTriageActions(
                onConfirm: onConfirm, onEdit: onEdit, onReject: onReject, onLinkToGoal: onLinkToGoal),
          ],
        ),
      ),
    );
  }
}
