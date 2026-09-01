import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';

/// Product/Service picker for [CatalogListingForm] (Issue #138,
/// acceptance criterion 2) — split out to stay under the file line
/// cap.
class CatalogListingTypeToggle extends StatelessWidget {
  final CatalogListingType value;
  final void Function(CatalogListingType) onChanged;

  const CatalogListingTypeToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ChoiceChip(
        label: const Text('Product'),
        selected: value == CatalogListingType.product,
        onSelected: (_) => onChanged(CatalogListingType.product),
      ),
      const SizedBox(width: 4),
      ChoiceChip(
        label: const Text('Service'),
        selected: value == CatalogListingType.service,
        onSelected: (_) => onChanged(CatalogListingType.service),
      ),
    ]);
  }
}
