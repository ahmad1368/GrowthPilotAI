import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Merchant/surplus-item identity fields for the new-listing form
/// (Issue #413, acceptance criterion 1).
class BarterBasicFields extends StatelessWidget {
  final BarterFormController form;

  const BarterBasicFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Merchant name'), controller: form.merchantName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Surplus item/service (e.g. Espresso Beans)'),
            controller: form.surplusItemName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Surplus item description'),
            controller: form.surplusItemDescription,
            maxLines: 2),
      ],
    );
  }
}
