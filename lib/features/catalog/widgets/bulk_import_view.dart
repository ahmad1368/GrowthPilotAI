import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_preview.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the paste-CSV import flow (Issue #141). This app has no
/// server/OS file picker wired up, so "upload" here is pasting CSV
/// text — genuinely parsed, validated, and saved, just without a
/// native file-open dialog. Purely presentational.
class BulkImportView extends StatelessWidget {
  final TextEditingController csvText;
  final List<List<String>> previewRows;
  final ImportSummary? summary;
  final VoidCallback onCopyTemplate;
  final VoidCallback onPreview;
  final VoidCallback onImport;

  const BulkImportView({
    super.key,
    required this.csvText,
    required this.previewRows,
    required this.summary,
    required this.onCopyTemplate,
    required this.onPreview,
    required this.onImport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ShadButton.ghost(onPressed: onCopyTemplate, child: const Text('Copy CSV Template')),
        ShadButton.ghost(onPressed: onPreview, child: const Text('Preview')),
        ShadButton.ghost(onPressed: onImport, child: const Text('Import')),
      ]),
      TextField(
        controller: csvText,
        maxLines: 5,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(hintText: 'Paste CSV content here...'),
      ),
      BulkImportPreview(rows: previewRows),
      BulkImportSummaryView(summary: summary),
    ]);
  }
}
