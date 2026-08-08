import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/business/build_product_import_template.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_view.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_products_from_csv.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

/// Owns the Bulk CSV Import demo's state (Issue #141). No NestJS/
/// worker-queue/Google Geocoding exists, so files are pasted as text
/// and processed synchronously — real parsing/validation/saving, on
/// a scale this local demo doesn't need to background.
class BulkImportBody extends StatefulWidget {
  const BulkImportBody({super.key});
  @override
  State<BulkImportBody> createState() => _BulkImportBodyState();
}

class _BulkImportBodyState extends State<BulkImportBody> {
  final _repos = ProductFormRepos();
  final _csvText = TextEditingController();
  List<List<String>> _previewRows = [];
  ImportSummary? _summary;

  void _copyTemplate() => Clipboard.setData(ClipboardData(text: BuildProductImportTemplate.call()));

  void _preview() => setState(() => _previewRows = ParseCsvRows.call(_csvText.text));

  void _import() => setState(() => _summary = importProductsFromCsv(_repos, _csvText.text));

  @override
  Widget build(BuildContext context) => BulkImportView(
        csvText: _csvText,
        previewRows: _previewRows,
        summary: _summary,
        onCopyTemplate: _copyTemplate,
        onPreview: _preview,
        onImport: _import,
      );
}
