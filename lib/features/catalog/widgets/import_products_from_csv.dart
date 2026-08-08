import 'package:growth_pilot_ai/business/dry_run_import_rows.dart';
import 'package:growth_pilot_ai/business/guess_column_mapping.dart';
import 'package:growth_pilot_ai/business/map_import_row.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/submit_product_form.dart';

/// Parses a CSV and saves only rows that pass a dry run against
/// [columnMap] (auto-guessed if omitted), reusing #140's
/// [submitProductForm] (Issue #141, extended for #213's Mapping Wizard).
ImportSummary importProductsFromCsv(
  ProductFormRepos repos,
  String csvText, {
  Map<String, int?>? columnMap,
}) {
  final rows = ParseCsvRows.call(csvText);
  if (rows.length < 2) return (importedCount: 0, errors: []);

  final dataRows = rows.sublist(1);
  final map = columnMap ?? GuessColumnMapping.call(rows.first);
  final skus = repos.productDetails.getAll().map((d) => d.sku).where((s) => s.isNotEmpty).toSet();
  final dryRun = DryRunImportRows.call(dataRows, map, skus);

  var imported = 0;
  final errors = <ImportRowError>[];
  for (var i = 0; i < dataRows.length; i++) {
    final result = dryRun[i];
    if (!result.valid) {
      errors.add((row: result.row, error: result.error));
      continue;
    }
    final rowMap = MapImportRow.call(map, dataRows[i]);
    submitProductForm(repos,
        editingListingId: 0,
        ownerId: 'You',
        title: rowMap['name'] ?? '',
        industry: rowMap['industry'] ?? '',
        category: rowMap['category'] ?? '',
        type: CatalogListingType.product,
        price: double.tryParse(rowMap['price'] ?? '') ?? 0,
        imageVariantIds: const [],
        lat: 49.2838,
        lng: -122.7932,
        sku: rowMap['sku']);
    imported++;
  }
  return (importedCount: imported, errors: errors);
}
