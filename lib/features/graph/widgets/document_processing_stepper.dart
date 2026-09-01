import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_processing_orchestrator_controller.dart';
import 'package:growth_pilot_ai/core/enum/document_processing_stage.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Progress Stepper: Upload -> Clean -> Extract -> Save" (Issue #232).
class DocumentProcessingStepper extends StatelessWidget {
  final DocumentProcessingOrchestratorController controller;

  const DocumentProcessingStepper({super.key, required this.controller});

  static const _steps = {
    DocumentProcessingStage.uploading: 'Upload',
    DocumentProcessingStage.cleaning: 'Clean',
    DocumentProcessingStage.extracting: 'Extract',
    DocumentProcessingStage.completed: 'Save',
  };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final stage = controller.stage.value;
      if (stage == DocumentProcessingStage.pending) return const SizedBox.shrink();
      if (stage == DocumentProcessingStage.failed) {
        return Text('Processing failed: ${controller.errorMessage.value ?? 'unknown error'}',
            style: const TextStyle(color: Colors.red, fontSize: 12));
      }
      final activeIndex = _steps.keys.toList().indexOf(stage);
      return Row(
        children: [
          for (final entry in _steps.entries)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(entry.value,
                  style: TextStyle(
                    color: _steps.keys.toList().indexOf(entry.key) <= activeIndex
                        ? colors.primary
                        : colors.mutedForeground,
                    fontSize: 12,
                    fontWeight: entry.key == stage ? FontWeight.w700 : FontWeight.w400,
                  )),
            ),
        ],
      );
    });
  }
}
