import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Buyer/seller/item/amount fields for the new-escrow form (Issue
/// #415, acceptance criterion 1).
class EscrowBasicFields extends StatelessWidget {
  final EscrowFormController form;

  const EscrowBasicFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Buyer name'), controller: form.buyerName),
        const SizedBox(height: 8),
        ShadInput(placeholder: const Text('Seller name'), controller: form.sellerName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Item/service (agreed listing terms)'),
            controller: form.itemDescription,
            maxLines: 2),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Amount to hold in escrow (\$)'),
            controller: form.amount,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
