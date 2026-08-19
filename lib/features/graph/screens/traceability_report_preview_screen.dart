import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_report_section_toggles.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Real-Time Document Preview & Validation Layer" (Issue #259) —
/// [PdfPreview] re-renders live whenever [TraceabilityController]'s
/// `enabledReportSections` changes. Its own built-in Share/Print
/// actions are the honest local stand-in for the issue's "Commit ->
/// S3 upload" step (no backend/S3 exists in this repo; see PR notes).
/// Tap-to-edit annotations aren't supported — PDF content in
/// [PdfPreview] isn't interactive at that level; use the Triage/
/// Traceability screens' existing edit flows instead.
class TraceabilityReportPreviewScreen extends StatelessWidget {
  const TraceabilityReportPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<TraceabilityController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Report Preview'), backgroundColor: colors.background),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TraceabilityReportSectionToggles(controller: controller),
          ),
          Expanded(
            child: Obx(() {
              // Reading enabledReportSections here makes Obx rebuild
              // PdfPreview with a fresh `build` closure on every toggle.
              controller.enabledReportSections.length;
              return PdfPreview(
                build: (format) => controller.buildReportPdfBytes(),
                pdfFileName: 'Traceability_Report_Draft.pdf',
              );
            }),
          ),
        ],
      ),
    );
  }
}
