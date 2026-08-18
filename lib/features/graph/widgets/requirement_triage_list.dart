import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_edit_dialog.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_triage_card.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_type_filter_chip.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The "Requirement Triage" screen's card list (Issue #228/#231/#234)
/// — respects [RequirementTriageController.typeFilter] for the
/// dashboard's drill-down.
class RequirementTriageList extends StatelessWidget {
  final RequirementTriageController controller;

  const RequirementTriageList({super.key, required this.controller});

  Future<void> _editAt(BuildContext context, int index) async {
    final edited = await showDialog<String>(
      context: context,
      builder: (_) => RequirementEditDialog(
          initialDescription: controller.requirements[index].description),
    );
    if (edited != null && edited.trim().isNotEmpty) controller.edit(index, edited);
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.requirements.isEmpty) {
        return Text('No candidate requirements found.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      final visible = controller.visibleIndices;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequirementTypeFilterChip(controller: controller),
          for (final i in visible)
            RequirementTriageCard(
              requirement: controller.requirements[i],
              isSelected: controller.selectedIndex.value == i,
              isBatchSelected: controller.batchSelected.contains(i),
              onTap: () => controller.selectRequirement(i),
              onBatchToggle: (_) => controller.toggleBatchSelected(i),
              onConfirm: () => controller.confirm(i),
              onReject: () => controller.reject(i),
              onEdit: () => _editAt(context, i),
              onPriorityChanged: (p) => controller.overridePriority(i, p),
              onStakeholderChanged: (s) => controller.overrideStakeholder(i, s),
            ),
        ],
      );
    });
  }
}
