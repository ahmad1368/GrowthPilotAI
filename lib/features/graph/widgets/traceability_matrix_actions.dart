import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_batch_export_button.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_pdf_export_button.dart';

/// Extracted from [TraceabilityMatrixScreen]'s AppBar (Issue #253) to
/// keep the screen under the SRP line budget as export actions
/// accumulated across #239/#245/#247/#250/#251/#253. The Excel/CSV/
/// Share-All buttons disable themselves while their own export is in
/// flight (Issue #254's duplicate-tap guard, mirroring
/// [TraceabilityPdfExportButton]'s existing behavior).
class TraceabilityMatrixActions extends StatelessWidget {
  const TraceabilityMatrixActions({super.key, required this.controller});

  final TraceabilityController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Obx(() => IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export to Excel',
            onPressed: controller.isExportingMatrix.value ? null : controller.exportMatrixToXlsx,
          )),
      Obx(() => IconButton(
            icon: const Icon(Icons.description_outlined),
            tooltip: 'Export to CSV',
            onPressed: controller.isExportingMatrix.value ? null : controller.exportMatrixToCsv,
          )),
      IconButton(
        icon: const Icon(Icons.picture_as_pdf_outlined),
        tooltip: 'Preview Report',
        onPressed: () => Get.toNamed('/requirements/traceability/report-preview'),
      ),
      Obx(() => IconButton(
            icon: const Icon(Icons.ios_share_outlined),
            tooltip: 'Share All (XLSX + CSV)',
            onPressed: controller.isSharingAll.value ? null : controller.shareAllExports,
          )),
      TraceabilityPdfExportButton(controller: controller),
      TraceabilityBatchExportButton(controller: controller),
      IconButton(
        icon: const Icon(Icons.history_outlined),
        tooltip: 'Export History',
        onPressed: () => Get.toNamed('/requirements/traceability/export-history'),
      ),
    ]);
  }
}
