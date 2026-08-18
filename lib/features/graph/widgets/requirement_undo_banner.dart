import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Add an 'Undo' feature for accidental rejections" (Issue #231).
class RequirementUndoBanner extends StatelessWidget {
  final RequirementTriageController controller;

  const RequirementUndoBanner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (!controller.canUndoReject.value) return const SizedBox.shrink();
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text('Requirement rejected.',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
            const Spacer(),
            ShadButton.ghost(onPressed: controller.undoReject, child: const Text('Undo')),
          ],
        ),
      );
    });
  }
}
