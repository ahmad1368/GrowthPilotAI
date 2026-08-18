import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_ingestion_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Document selection panel (Issue #225) — flat, no Glassmorphism.
class DocumentUploadPanel extends StatelessWidget {
  final DocumentIngestionController controller;

  const DocumentUploadPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadButton(onPressed: controller.pick, child: const Text('Select document (PDF/DOCX)')),
        const SizedBox(height: 8),
        Obx(() {
          final document = controller.selectedDocument.value;
          if (document == null) return const SizedBox.shrink();
          final error = controller.validationMessage;
          return Text(
            error ?? '${document.fileName} (${(document.sizeBytes / 1024).toStringAsFixed(0)} KB) selected.',
            style: TextStyle(color: error != null ? Colors.red : colors.foreground, fontSize: 12),
          );
        }),
      ],
    );
  }
}
