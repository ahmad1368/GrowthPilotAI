import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';

/// "Mobile Layout: Drill-Down Tree View... Business Goal A ->
/// Requirement 1.1 -> Test Case TC-01" (Issue #239) — orange goals have
/// no linked requirements (Gap Analysis); a trailing "Unlinked
/// Requirements" node (red) lists requirements linked to no goal.
class TraceabilityTreeView extends StatelessWidget {
  final TraceabilityController controller;
  final TraceabilityQuickFilter? filter;

  const TraceabilityTreeView({super.key, required this.controller, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filtered = controller.filteredRequirements(filter).map((r) => r.id).toSet();
      final unlinked = controller.requirementList
          .where((r) => controller.requirementIdsWithoutGoal.contains(r.id) && filtered.contains(r.id))
          .toList();
      return Column(
        children: [
          for (final goal in controller.goalList)
            ExpansionTile(
              title: Text(goal.title,
                  style: TextStyle(
                      color: controller.goalIdsWithoutRequirements.contains(goal.id)
                          ? Colors.orange
                          : null)),
              children: [
                for (final r in controller.requirementsForGoal(goal.id))
                  if (filtered.contains(r.id))
                    ExpansionTile(
                      title: Text('${r.reqCode} ${r.description}'),
                      children: [
                        for (final t in controller.testCasesForRequirement(r.id))
                          ListTile(title: Text('${t.tcCode} ${t.title}')),
                      ],
                    ),
              ],
            ),
          if (unlinked.isNotEmpty)
            ExpansionTile(
              title: const Text('Unlinked Requirements', style: TextStyle(color: Colors.red)),
              children: [for (final r in unlinked) ListTile(title: Text('${r.reqCode} ${r.description}'))],
            ),
        ],
      );
    });
  }
}
