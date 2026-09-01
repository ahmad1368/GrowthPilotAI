import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_fields.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_type_toggle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Compact listing creation form (Issue #138) — always uses fixed
/// pricing for simplicity; the entity/business layer still supports
/// price-range and RFQ modes for listings created another way.
class CatalogListingForm extends StatefulWidget {
  final void Function(
      {required String title,
      required String industry,
      required String category,
      required CatalogListingType type,
      required double price}) onCreate;

  const CatalogListingForm({super.key, required this.onCreate});

  @override
  State<CatalogListingForm> createState() => _CatalogListingFormState();
}

class _CatalogListingFormState extends State<CatalogListingForm> {
  final _title = TextEditingController();
  final _industry = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();
  CatalogListingType _type = CatalogListingType.product;

  void _submit() {
    widget.onCreate(
      title: _title.text,
      industry: _industry.text,
      category: _category.text,
      type: _type,
      price: double.tryParse(_price.text) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CatalogListingTypeToggle(value: _type, onChanged: (t) => setState(() => _type = t)),
      CatalogListingFields(title: _title, industry: _industry, category: _category, price: _price),
      ShadButton.ghost(onPressed: _submit, child: const Text('Add Listing')),
    ]);
  }
}
