import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Filtered view of the Requirements List" indicator (Issue #234's
/// drill-down AC) — shown only while a `typeFilter` is active.
class RequirementTypeFilterChip extends StatelessWidget {
  final RequirementTriageController controller;

  const RequirementTypeFilterChip({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final filter = controller.typeFilter.value;
      if (filter == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Text('Filtered: ${filter.name}',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
            const SizedBox(width: 8),
            ShadButton.ghost(
              onPressed: () => controller.setTypeFilter(null),
              child: const Text('Clear filter'),
            ),
          ],
        ),
      );
    });
  }
}
