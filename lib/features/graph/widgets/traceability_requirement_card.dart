import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_requirement_action_row.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_requirement_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One requirement's card in the "Traceability Matrix" (Issue #238/
/// #242/#240) — code + description + dev status + linked test cases +
/// history + "Predict Impact".
class TraceabilityRequirementCard extends StatefulWidget {
  final TraceabilityController controller;
  final TraceableRequirementEntity requirement;

  const TraceabilityRequirementCard({super.key, required this.controller, required this.requirement});

  @override
  State<TraceabilityRequirementCard> createState() => _TraceabilityRequirementCardState();
}

class _TraceabilityRequirementCardState extends State<TraceabilityRequirementCard> {
  final _testCaseController = TextEditingController();

  void _addTestCase() {
    final title = _testCaseController.text.trim();
    if (title.isEmpty) return;
    final testCaseId = widget.controller.addTestCase(title);
    widget.controller.linkTestCaseToRequirement(widget.requirement.id, testCaseId);
    _testCaseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final testCases = widget.controller.testCasesForRequirement(widget.requirement.id);
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TraceabilityRequirementHeader(controller: widget.controller, requirement: widget.requirement),
            Wrap(
                spacing: 6,
                children: [for (final t in testCases) Chip(label: Text('${t.tcCode} ${t.title}'))]),
            TraceabilityRequirementActionRow(
              controller: widget.controller,
              requirement: widget.requirement,
              testCaseController: _testCaseController,
              onAddTestCase: _addTestCase,
            ),
          ],
        ),
      );
    });
  }
}
