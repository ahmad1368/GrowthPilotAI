import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Batch Actions: Select All and Approve" (Issue #231).
class RequirementBatchActionBar extends StatelessWidget {
  final RequirementTriageController controller;

  const RequirementBatchActionBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.requirements.isEmpty) return const SizedBox.shrink();
      final count = controller.batchSelected.length;
      return Row(
        children: [
          ShadButton.outline(onPressed: controller.selectAllPending, child: const Text('Select All')),
          const SizedBox(width: 8),
          ShadButton(
            onPressed: count == 0 ? null : controller.approveSelected,
            child: Text('Approve Selected ($count)'),
          ),
          const SizedBox(width: 8),
          if (count > 0)
            Text('$count selected', style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
        ],
      );
    });
  }
}
