import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/features/graph/widgets/impact_report_dialog.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_history_timeline.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Add test case" + History + "Predict Impact" row (Issue #238/#240)
/// — split out of [TraceabilityRequirementCard] to keep it under the
/// 50-line guideline.
class TraceabilityRequirementActionRow extends StatelessWidget {
  final TraceabilityController controller;
  final TraceableRequirementEntity requirement;
  final TextEditingController testCaseController;
  final VoidCallback onAddTestCase;

  const TraceabilityRequirementActionRow({
    super.key,
    required this.controller,
    required this.requirement,
    required this.testCaseController,
    required this.onAddTestCase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadInput(controller: testCaseController, placeholder: const Text('Add test case...')),
        ),
        const SizedBox(width: 6),
        ShadButton.outline(onPressed: onAddTestCase, child: const Text('Add')),
        ShadButton.ghost(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => RequirementHistoryTimeline(entries: controller.historyForRequirement(requirement.id)),
          ),
          child: const Text('History'),
        ),
        ShadButton.ghost(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => ImpactReportDialog(report: controller.computeImpactReport(requirement.id)),
          ),
          child: const Text('Predict Impact'),
        ),
      ],
    );
  }
}
