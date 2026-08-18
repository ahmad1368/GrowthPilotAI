import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/text_sanitization_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Diff View... toggle between the original extracted text and the
/// AI-Ready version" + "Advanced Cleaning" toggle (Issue #227) — flat,
/// no Glassmorphism.
class TextDiffView extends StatelessWidget {
  final TextSanitizationController controller;

  const TextDiffView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final result = controller.result.value;
      if (result == null) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShadSwitch(
                value: controller.showSanitized.value,
                onChanged: (v) => controller.showSanitized.value = v,
              ),
              const SizedBox(width: 8),
              Text('Show AI-Ready version', style: TextStyle(color: colors.foreground, fontSize: 12)),
            ],
          ),
          Row(
            children: [
              ShadSwitch(
                value: controller.stripBoilerplate.value,
                onChanged: controller.toggleStripBoilerplate,
              ),
              const SizedBox(width: 8),
              Text('Advanced cleaning (legal footers, ToC)',
                  style: TextStyle(color: colors.foreground, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(controller.showSanitized.value ? result.sanitizedText : result.rawText,
              style: TextStyle(color: colors.foreground, fontSize: 13)),
        ],
      );
    });
  }
}
