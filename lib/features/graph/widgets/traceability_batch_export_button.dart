import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';

/// Extracted from [TraceabilityMatrixActions] to keep it under the
/// SRP line budget — the reactive icon button that triggers Issue
/// #258's PDF+XLSX+CSV ZIP bundle export.
class TraceabilityBatchExportButton extends StatelessWidget {
  const TraceabilityBatchExportButton({super.key, required this.controller});

  final TraceabilityController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
          icon: controller.isBatchExporting.value
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.folder_zip_outlined),
          tooltip: 'Export ZIP Bundle (PDF + XLSX + CSV)',
          onPressed: controller.isBatchExporting.value ? null : controller.exportBatchZip,
        ));
  }
}
