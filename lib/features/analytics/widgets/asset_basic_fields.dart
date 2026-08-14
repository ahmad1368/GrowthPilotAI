import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Seller/asset identity fields for the new-listing form (Issue #412,
/// acceptance criterion 1).
class AssetBasicFields extends StatelessWidget {
  final AssetFormController form;

  const AssetBasicFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Seller name'), controller: form.sellerName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Asset (e.g. Commercial Fridge)'),
            controller: form.assetName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Condition description'),
            controller: form.conditionDescription,
            maxLines: 2),
      ],
    );
  }
}
