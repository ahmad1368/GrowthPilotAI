import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Supplier/product identity fields for the new-catalog-line form
/// (Issue #417, acceptance criterion 1).
class SeasonalCatalogBasicFields extends StatelessWidget {
  final SeasonalCatalogFormController form;

  const SeasonalCatalogBasicFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Supplier name'), controller: form.supplierName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Seasonal product (e.g. Holiday Gift Sets)'),
            controller: form.productName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Product description'),
            controller: form.productDescription,
            maxLines: 2),
      ],
    );
  }
}
