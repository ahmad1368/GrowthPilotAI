import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The 3 input fields for a warranty-claim entry (Issue #389): item name,
/// claim payout cost, and coverage revenue collected.
class WarrantyClaimFields extends StatelessWidget {
  final TextEditingController itemNameController;
  final TextEditingController claimCostController;
  final TextEditingController coverageRevenueController;

  const WarrantyClaimFields({
    super.key,
    required this.itemNameController,
    required this.claimCostController,
    required this.coverageRevenueController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Item name'), controller: itemNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Claim payout cost (\$)'),
            controller: claimCostController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Coverage revenue collected (\$)'),
            controller: coverageRevenueController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
