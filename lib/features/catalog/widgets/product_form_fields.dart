import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_form_draft_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';

/// Owns the form's raw field state (Issue #140) — separated from
/// [ProductFormBody] so loading a draft/listing isn't inline widget
/// logic.
class ProductFormFields {
  final title = TextEditingController();
  final industry = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  CatalogListingType type = CatalogListingType.product;
  int editingListingId = 0;
  List<int> imageIds = [];

  void loadFromDraft(ProductFormDraftEntity draft) {
    editingListingId = draft.editingListingId;
    title.text = draft.title;
    industry.text = draft.industry;
    category.text = draft.category;
    type = CatalogListingType.values[draft.dbListingType];
    price.text = draft.price == 0 ? '' : draft.price.toString();
    imageIds = _parseIds(draft.imageVariantIdsCsv);
  }

  void loadFromListing(CatalogListingEntity listing) {
    editingListingId = listing.id;
    title.text = listing.title;
    industry.text = listing.industry;
    category.text = listing.category;
    type = listing.listingType;
    imageIds = _parseIds(listing.imageVariantIdsCsv);
  }

  void reset() {
    editingListingId = 0;
    title.clear();
    industry.clear();
    category.clear();
    price.clear();
    imageIds = [];
  }

  static List<int> _parseIds(String csv) =>
      csv.split(',').where((s) => s.isNotEmpty).map(int.parse).toList();
}
