import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Pricing, deposit, and delivery-window fields for the
/// new-catalog-line form (Issue #417, acceptance criteria 1-2).
class SeasonalCatalogTermsFields extends StatelessWidget {
  final SeasonalCatalogFormController form;

  const SeasonalCatalogTermsFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Unit price (\$)'),
            controller: form.unitPrice,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Deposit percent (%)'),
            controller: form.depositPercent,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Delivery window (days out)'),
            controller: form.deliveryWindowDays,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
