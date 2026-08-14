import 'package:growth_pilot_ai/business/compute_eta_seconds.dart';
import 'package:growth_pilot_ai/business/dry_run_import_rows.dart';
import 'package:growth_pilot_ai/business/guess_column_mapping.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_progress.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/save_valid_import_row.dart';

/// Parses a CSV and saves only rows that pass a dry run against
/// [columnMap] (auto-guessed if omitted), reusing #140's save path
/// (Issue #141/#213). Reports real, measured progress via
/// [onProgress] (Issue #217) — no fabricated delays.
Future<ImportSummary> importProductsFromCsv(
  ProductFormRepos repos,
  String csvText, {
  Map<String, int?>? columnMap,
  void Function(ImportProgress)? onProgress,
}) async {
  final rows = ParseCsvRows.call(csvText);
  if (rows.length < 2) return (importedCount: 0, errors: <ImportRowError>[]);

  final dataRows = rows.sublist(1);
  final map = columnMap ?? GuessColumnMapping.call(rows.first);
  final skus = repos.productDetails.getAll().map((d) => d.sku).where((s) => s.isNotEmpty).toSet();
  onProgress?.call((stage: 'Validating', current: 0, total: dataRows.length, etaSeconds: 0));
  final dryRun = DryRunImportRows.call(dataRows, map, skus);

  final stopwatch = Stopwatch()..start();
  var imported = 0;
  final errors = <ImportRowError>[];
  for (var i = 0; i < dataRows.length; i++) {
    final result = dryRun[i];
    if (result.valid) {
      saveValidImportRow(repos, map, dataRows[i]);
      imported++;
    } else {
      errors.add((row: result.row, error: result.error));
    }
    final eta = ComputeEtaSeconds.call(
        elapsedSeconds: stopwatch.elapsedMicroseconds / 1e6, processed: i + 1, total: dataRows.length);
    onProgress?.call((stage: 'Saving', current: i + 1, total: dataRows.length, etaSeconds: eta));
    await Future.delayed(Duration.zero);
  }
  return (importedCount: imported, errors: errors);
}
