import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Organizer/item identity fields for the new-campaign form (Issue
/// #414, acceptance criterion 1).
class GroupPurchaseBasicFields extends StatelessWidget {
  final GroupPurchaseFormController form;

  const GroupPurchaseBasicFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Organizer name'), controller: form.organizerName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Supply item (e.g. Recycled Takeout Boxes)'),
            controller: form.itemName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Item description'),
            controller: form.itemDescription,
            maxLines: 2),
      ],
    );
  }
}
