import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Lets the demo switch the form into "Edit" mode for an existing
/// listing (Issue #140, acceptance criterion "Edit Mode Persistence").
class ProductFormListingPicker extends StatelessWidget {
  final List<CatalogListingEntity> listings;
  final void Function(CatalogListingEntity) onEdit;

  const ProductFormListingPicker({super.key, required this.listings, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    if (listings.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Existing listings:', style: TextStyle(fontSize: 12)),
      for (final listing in listings)
        Row(children: [
          Expanded(child: Text(listing.title, style: const TextStyle(fontSize: 12))),
          ShadButton.ghost(onPressed: () => onEdit(listing), child: const Text('Edit')),
        ]),
    ]);
  }
}
