import 'package:growth_pilot_ai/business/map_import_row.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/submit_product_form.dart';

/// Saves one already-validated CSV row (Issue #141/#213) — split out
/// of [importProductsFromCsv] to keep its loop body small.
void saveValidImportRow(ProductFormRepos repos, Map<String, int?> columnMap, List<String> dataRow) {
  final rowMap = MapImportRow.call(columnMap, dataRow);
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
}
