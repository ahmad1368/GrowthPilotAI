import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_callbacks.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_column_mapper.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_preview.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_progress_bar.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_progress.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/run_bulk_import_preview.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the paste-CSV import flow: mapping, preview, progress
/// (Issue #141/#213/#217). Purely presentational.
class BulkImportView extends StatelessWidget {
  final TextEditingController csvText;
  final BulkImportPreviewState? previewState;
  final ImportSummary? summary;
  final ImportProgress? progress;
  final BulkImportCallbacks callbacks;

  const BulkImportView(
      {super.key,
      required this.csvText,
      required this.previewState,
      required this.summary,
      required this.progress,
      required this.callbacks});

  @override
  Widget build(BuildContext context) {
    final state = previewState;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ShadButton.ghost(onPressed: callbacks.onCopyTemplate, child: const Text('Copy CSV Template')),
        ShadButton.ghost(onPressed: callbacks.onPreview, child: const Text('Preview')),
        ShadButton.ghost(onPressed: callbacks.onImport, child: const Text('Import Valid Rows')),
      ]),
      TextField(
          controller: csvText,
          maxLines: 5,
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(hintText: 'Paste CSV content here...')),
      BulkImportColumnMapper(
          header: state?.header ?? [], columnMap: state?.columnMap ?? {}, onChanged: callbacks.onMapChanged),
      BulkImportProgressBar(progress: progress),
      BulkImportPreview(results: state?.results ?? []),
      BulkImportSummaryView(summary: summary, onCopyErrorLog: callbacks.onCopyErrorLog),
    ]);
  }
}
