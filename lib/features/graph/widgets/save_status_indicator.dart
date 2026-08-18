import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';
import 'package:growth_pilot_ai/controllers/visual_modeling_bridge_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Native Overlays: Save Status indicator" (Issue #221) — flat text
/// reacting to `onSaveStatusChanged` bridge messages.
class SaveStatusIndicator extends StatelessWidget {
  final VisualModelingBridgeController controller;

  const SaveStatusIndicator({super.key, required this.controller});

  String _label(CanvasSaveStatus status) => switch (status) {
        CanvasSaveStatus.idle => '',
        CanvasSaveStatus.saving => 'Saving...',
        CanvasSaveStatus.saved => 'All changes saved',
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final label = _label(controller.saveStatus.value);
      if (label.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(label, style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
      );
    });
  }
}
