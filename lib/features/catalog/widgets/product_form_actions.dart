import 'package:growth_pilot_ai/features/catalog/widgets/add_demo_product_image.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/purge_stale_product_images.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/save_product_form_draft.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/submit_product_form_fields.dart';

/// Business orchestration for the Add/Edit Product form (Issue #140)
/// — split out of [ProductFormBody] so state-mutation logic isn't
/// inline widget code.
class ProductFormActions {
  final ProductFormRepos repos;
  final ProductFormFields fields;
  ProductFormActions(this.repos, this.fields);

  void saveDraft() => saveProductFormDraft(repos,
      editingListingId: fields.editingListingId,
      title: fields.title.text,
      industry: fields.industry.text,
      category: fields.category.text,
      type: fields.type,
      price: double.tryParse(fields.price.text) ?? 0,
      imageIds: fields.imageIds);

  void addImage() {
    fields.imageIds = [...fields.imageIds, addDemoProductImage(repos)];
    saveDraft();
  }

  void removeImage(int id) {
    fields.imageIds = fields.imageIds.where((i) => i != id).toList();
    saveDraft();
  }

  void cleanupStaleImages() {
    final referenced = <int>{...fields.imageIds};
    for (final l in repos.listings.getAll()) {
      referenced.addAll(l.imageVariantIdsCsv.split(',').where((s) => s.isNotEmpty).map(int.parse));
    }
    purgeStaleProductImages(repos, referenced);
  }

  List<String> submit() => submitProductFormFields(repos, fields);
}
