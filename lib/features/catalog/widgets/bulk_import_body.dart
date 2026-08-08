import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/business/build_error_log_csv.dart';
import 'package:growth_pilot_ai/business/build_product_import_template.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/apply_column_map_change.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_view.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_products_from_csv.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_progress.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/run_bulk_import_preview.dart';
/// Owns the Bulk CSV Import demo's state (Issue #141/#213/#217).
class BulkImportBody extends StatefulWidget {
  const BulkImportBody({super.key});
  @override
  State<BulkImportBody> createState() => _BulkImportBodyState();
}
class _BulkImportBodyState extends State<BulkImportBody> {
  final _repos = ProductFormRepos();
  final _csvText = TextEditingController();
  BulkImportPreviewState? _previewState;
  ImportProgress? _progress;
  ImportSummary? _summary;
  Future<void> _import() async {
    final s = await importProductsFromCsv(_repos, _csvText.text,
        columnMap: _previewState?.columnMap, onProgress: (p) => setState(() => _progress = p));
    setState(() {
      _summary = s;
      _previewState = null;
      _progress = null;
    });
    HapticFeedback.mediumImpact();
  }
  @override
  Widget build(BuildContext context) => BulkImportView(
        csvText: _csvText,
        previewState: _previewState,
        summary: _summary,
        progress: _progress,
        callbacks: (
          onCopyTemplate: () => Clipboard.setData(ClipboardData(text: BuildProductImportTemplate.call())),
          onPreview: () => setState(() => _previewState = runBulkImportPreview(_repos, _csvText.text)),
          onImport: _import,
          onCopyErrorLog: () =>
              Clipboard.setData(ClipboardData(text: BuildErrorLogCsv.call(_summary?.errors ?? []))),
          onMapChanged: (field, index) =>
              setState(() => _previewState = applyColumnMapChange(_previewState, field, index)),
        ),
      );
}
