import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Pricing, zone, and pickup-window fields for the new-listing form
/// (Issue #412, acceptance criteria 1-2).
class AssetPricingFields extends StatelessWidget {
  final AssetFormController form;

  const AssetPricingFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Market value (\$)'),
            controller: form.marketValue,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Discounted asking price (\$)'),
            controller: form.askingPrice,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Commercial zone (e.g. Downtown Vancouver)'),
            controller: form.commercialZone),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Pickup deadline (days)'),
            controller: form.pickupDays,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
