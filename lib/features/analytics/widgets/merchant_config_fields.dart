import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The business name/ID/commission/cap/notes fields for adding or
/// editing a merchant configuration profile (Issue #338).
class MerchantConfigFields extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController businessIdController;
  final TextEditingController commissionRateController;
  final TextEditingController transactionCapController;
  final TextEditingController notesController;

  const MerchantConfigFields({
    super.key,
    required this.businessNameController,
    required this.businessIdController,
    required this.commissionRateController,
    required this.transactionCapController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Business name'),
            controller: businessNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Business ID'),
            controller: businessIdController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Commission rate %'),
            controller: commissionRateController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Monthly transaction cap'),
            controller: transactionCapController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Notes (optional)'),
            controller: notesController),
      ],
    );
  }
}
