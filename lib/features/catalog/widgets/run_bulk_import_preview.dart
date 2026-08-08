import 'package:growth_pilot_ai/business/dry_run_import_rows.dart';
import 'package:growth_pilot_ai/business/guess_column_mapping.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

typedef BulkImportPreviewState = ({
  List<String> header,
  Map<String, int?> columnMap,
  List<DryRunRowResult> results,
});

/// Parses the pasted CSV, guesses the column mapping, and runs a dry
/// run — the "Preview" step (Issue #213). Returns null for blank
/// input.
BulkImportPreviewState? runBulkImportPreview(ProductFormRepos repos, String csvText) {
  final rows = ParseCsvRows.call(csvText);
  if (rows.isEmpty) return null;
  final header = rows.first;
  final columnMap = GuessColumnMapping.call(header);
  final skus = repos.productDetails.getAll().map((d) => d.sku).where((s) => s.isNotEmpty).toSet();
  final results = DryRunImportRows.call(rows.sublist(1), columnMap, skus);
  return (header: header, columnMap: columnMap, results: results);
}
