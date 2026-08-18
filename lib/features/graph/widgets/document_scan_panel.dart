import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_scan_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Document Scanner" entry point (Issue #226/#227) — flat, no
/// Glassmorphism. Shows an "OCR in Progress" state while
/// [DocumentScanController.isProcessing] is true (AC's "Visual
/// Feedback"), though there's no WebSocket to notify a background
/// job's completion — this runs entirely on-device (see PR notes).
class DocumentScanPanel extends StatelessWidget {
  final DocumentScanController controller;

  const DocumentScanPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadButton(
            onPressed: controller.isProcessing.value ? null : controller.scanAndExtract,
            child: Text(controller.isProcessing.value ? 'OCR in progress...' : 'Scan document'),
          ),
          const SizedBox(height: 8),
          if (controller.errorMessage.value != null)
            Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red, fontSize: 12)),
          if (controller.result.value != null) ...[
            Text(controller.result.value!.fullText,
                style: TextStyle(color: colors.foreground, fontSize: 13)),
            Text('Confidence: ${((controller.result.value!.confidence ?? 0) * 100).toStringAsFixed(0)}%',
                style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
          ],
        ],
      );
    });
  }
}
