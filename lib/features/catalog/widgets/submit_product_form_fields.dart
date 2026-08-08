import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/submit_product_form.dart';

/// Submits the current form fields, clearing them + the draft on
/// success (Issue #140) — split out of [ProductFormActions].
List<String> submitProductFormFields(ProductFormRepos repos, ProductFormFields fields) {
  final errors = submitProductForm(repos,
      editingListingId: fields.editingListingId,
      ownerId: 'You',
      title: fields.title.text,
      industry: fields.industry.text,
      category: fields.category.text,
      type: fields.type,
      price: double.tryParse(fields.price.text) ?? 0,
      imageVariantIds: fields.imageIds,
      lat: 49.2838,
      lng: -122.7932);
  if (errors.isEmpty) {
    repos.draft.clear();
    fields.reset();
  }
  return errors;
}
