import 'package:growth_pilot_ai/business/build_import_row_map.dart';
import 'package:growth_pilot_ai/business/detect_duplicate_sku.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';
import 'package:growth_pilot_ai/business/validate_import_row.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/submit_product_form.dart';

/// Parses+validates a CSV of products and saves the valid rows,
/// reusing #140's [submitProductForm] so imports go through the same
/// save path as the manual form (Issue #141).
ImportSummary importProductsFromCsv(ProductFormRepos repos, String csvText) {
  final rows = ParseCsvRows.call(csvText);
  if (rows.length < 2) return (importedCount: 0, errors: []);

  final header = rows.first.map((h) => h.toLowerCase()).toList();
  final skus = repos.productDetails.getAll().map((d) => d.sku).where((s) => s.isNotEmpty).toSet();
  var imported = 0;
  final errors = <ImportRowError>[];

  for (var i = 1; i < rows.length; i++) {
    final map = BuildImportRowMap.call(header, rows[i]);
    final rowErrors = ValidateImportRow.call(map);
    final sku = map['sku'] ?? '';
    if (rowErrors.isEmpty && DetectDuplicateSku.call(sku, skus)) {
      rowErrors.add('Duplicate SKU for this vendor.');
    }
    if (rowErrors.isNotEmpty) {
      errors.add((row: i + 1, error: rowErrors.join('; ')));
      continue;
    }
    submitProductForm(repos,
        editingListingId: 0,
        ownerId: 'You',
        title: map['name'] ?? '',
        industry: map['industry'] ?? '',
        category: map['category'] ?? '',
        type: CatalogListingType.product,
        price: double.tryParse(map['price'] ?? '') ?? 0,
        imageVariantIds: const [],
        lat: 49.2838,
        lng: -122.7932,
        sku: sku);
    skus.add(sku);
    imported++;
  }
  return (importedCount: imported, errors: errors);
}
