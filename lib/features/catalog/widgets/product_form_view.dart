import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_basic_step.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_callbacks.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_listing_picker.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_media_step.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_step_tabs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the 2-step Add/Edit Product form (Issue #140). Purely presentational.
class ProductFormView extends StatelessWidget {
  final ProductFormFields fields;
  final bool resumedDraft;
  final int step;
  final List<String> errors;
  final List<CatalogListingEntity> listings;
  final ProductFormCallbacks callbacks;

  const ProductFormView({
    super.key,
    required this.fields,
    required this.resumedDraft,
    required this.step,
    required this.errors,
    required this.listings,
    required this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (resumedDraft) const Text('Resumed your in-progress draft.', style: TextStyle(fontSize: 12)),
      ProductFormListingPicker(listings: listings, onEdit: callbacks.onEditListing),
      ProductFormStepTabs(onStepChanged: callbacks.onStepChanged),
      if (step == 0)
        ProductFormBasicStep(fields: fields, onTypeChanged: callbacks.onTypeChanged)
      else
        ProductFormMediaStep(
            imageIds: fields.imageIds,
            onAddImage: callbacks.onAddImage,
            onRemoveImage: callbacks.onRemoveImage,
            onCleanupStaleImages: callbacks.onCleanupStaleImages),
      for (final error in errors) Text(error, style: const TextStyle(fontSize: 12, color: Colors.red)),
      ShadButton.ghost(
          onPressed: callbacks.onSubmit,
          child: Text(fields.editingListingId == 0 ? 'Create Listing' : 'Save Changes')),
    ]);
  }
}
