import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/business/build_error_log_csv.dart';
import 'package:growth_pilot_ai/business/build_product_import_template.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_view.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_products_from_csv.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/run_bulk_import_preview.dart';

/// Owns the Bulk CSV Import demo's state (Issue #141/#213). No
/// NestJS/BullMQ/WebSocket exists, so CSV is pasted+processed inline.
class BulkImportBody extends StatefulWidget {
  const BulkImportBody({super.key});
  @override
  State<BulkImportBody> createState() => _BulkImportBodyState();
}

class _BulkImportBodyState extends State<BulkImportBody> {
  final _repos = ProductFormRepos();
  final _csvText = TextEditingController();
  BulkImportPreviewState? _previewState;
  ImportSummary? _summary;

  void _import() => setState(() {
        _summary = importProductsFromCsv(_repos, _csvText.text, columnMap: _previewState?.columnMap);
        _previewState = null;
      });

  void _mapChanged(String field, int? index) => setState(() {
        final s = _previewState;
        if (s == null) return;
        _previewState = (header: s.header, columnMap: {...s.columnMap, field: index}, results: s.results);
      });

  @override
  Widget build(BuildContext context) => BulkImportView(
        csvText: _csvText,
        previewState: _previewState,
        summary: _summary,
        callbacks: (
          onCopyTemplate: () => Clipboard.setData(ClipboardData(text: BuildProductImportTemplate.call())),
          onPreview: () => setState(() => _previewState = runBulkImportPreview(_repos, _csvText.text)),
          onImport: _import,
          onCopyErrorLog: () =>
              Clipboard.setData(ClipboardData(text: BuildErrorLogCsv.call(_summary?.errors ?? []))),
          onMapChanged: _mapChanged,
        ),
      );
}
