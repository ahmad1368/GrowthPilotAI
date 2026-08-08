import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_type_toggle.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';

/// Step 1 "Basic Info" + "Pricing & Availability" combined (Issue
/// #140) — reuses the existing #138 field widgets rather than
/// duplicating them across two steps.
class ProductFormBasicStep extends StatelessWidget {
  final ProductFormFields fields;
  final void Function(CatalogListingType) onTypeChanged;

  const ProductFormBasicStep({super.key, required this.fields, required this.onTypeChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CatalogListingTypeToggle(value: fields.type, onChanged: onTypeChanged),
      CatalogListingFields(
          title: fields.title, industry: fields.industry, category: fields.category, price: fields.price),
    ]);
  }
}
