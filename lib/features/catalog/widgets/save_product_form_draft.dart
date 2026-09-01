import 'package:growth_pilot_ai/core/data/entities/product_form_draft_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

/// Persists the in-progress form state so it can be resumed after the
/// app closes (Issue #140, acceptance criterion "Resume capability").
void saveProductFormDraft(
  ProductFormRepos repos, {
  required int editingListingId,
  required String title,
  required String industry,
  required String category,
  required CatalogListingType type,
  required double price,
  required List<int> imageIds,
}) {
  repos.draft.save(ProductFormDraftEntity(
    editingListingId: editingListingId,
    title: title,
    industry: industry,
    category: category,
    dbListingType: type.index,
    price: price,
    imageVariantIdsCsv: imageIds.join(','),
    updatedAt: DateTime.now(),
  ));
}
