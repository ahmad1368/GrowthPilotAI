import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/enum/pdf_export_job_status.dart';

/// Extracted from [TraceabilityMatrixScreen]'s AppBar (Issue #251) to
/// keep the screen under the SRP line budget — the reactive
/// preparing/idle icon button that triggers [TraceabilityController]'s
/// one-tap PDF export job.
class TraceabilityPdfExportButton extends StatelessWidget {
  const TraceabilityPdfExportButton({super.key, required this.controller});

  final TraceabilityController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isPreparing = controller.pdfExportJobStatus.value == PdfExportJobStatus.preparing;
      return IconButton(
        icon: isPreparing
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.picture_as_pdf),
        tooltip: 'Export PDF Report',
        onPressed: isPreparing
            ? null
            : () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Preparing PDF report…')));
                controller.exportReportPdfViaJob();
              },
      );
    });
  }
}
