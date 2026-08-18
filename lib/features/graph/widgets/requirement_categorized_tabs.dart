import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/group_requirements_by_priority.dart';
import 'package:growth_pilot_ai/business/group_requirements_by_stakeholder.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/moscow_priority_dropdown.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_group_section.dart';

/// "Categorized Views: Stakeholders View, Priority Matrix" (Issue
/// #229) — tabbed grouping of the same triage list, instead of one
/// long list.
class RequirementCategorizedTabs extends StatelessWidget {
  final RequirementTriageController controller;

  const RequirementCategorizedTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            const TabBar(tabs: [Tab(text: 'Stakeholders View'), Tab(text: 'Priority Matrix')]),
            Expanded(
              child: Obx(() {
                final byStakeholder = GroupRequirementsByStakeholder.call(controller.requirements);
                final byPriority = GroupRequirementsByPriority.call(controller.requirements);
                return TabBarView(children: [
                  ListView(children: [
                    for (final entry in byStakeholder.entries)
                      RequirementGroupSection(label: entry.key, requirements: entry.value),
                  ]),
                  ListView(children: [
                    for (final entry in byPriority.entries)
                      RequirementGroupSection(
                          label: MoscowPriorityDropdown.labelFor(entry.key), requirements: entry.value),
                  ]),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
