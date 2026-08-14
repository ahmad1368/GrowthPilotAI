import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Pricing, threshold, and deadline fields for the new-campaign form
/// (Issue #414, acceptance criterion 1).
class GroupPurchaseTermsFields extends StatelessWidget {
  final GroupPurchaseFormController form;

  const GroupPurchaseTermsFields({super.key, required this.form});

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
            placeholder: const Text('Minimum quantity threshold'),
            controller: form.minQuantityThreshold,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Deadline (days)'),
            controller: form.deadlineDays,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
