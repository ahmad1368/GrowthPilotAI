import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The business name/ID/commission/cap/notes fields for adding or
/// editing a merchant configuration profile (Issue #338), including the
/// percentage-or-fixed-amount commission structure toggle (Issue #348,
/// acceptance criterion 1).
class MerchantConfigFields extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController businessIdController;
  final CommissionType commissionType;
  final ValueChanged<CommissionType> onCommissionTypeChanged;
  final TextEditingController commissionRateController;
  final TextEditingController commissionFixedAmountController;
  final TextEditingController transactionCapController;
  final TextEditingController notesController;

  const MerchantConfigFields({
    super.key,
    required this.businessNameController,
    required this.businessIdController,
    required this.commissionType,
    required this.onCommissionTypeChanged,
    required this.commissionRateController,
    required this.commissionFixedAmountController,
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
        Wrap(spacing: 8, children: [
          for (final type in CommissionType.values)
            if (commissionType == type)
              ShadButton(
                onPressed: () => onCommissionTypeChanged(type),
                child: Text(type == CommissionType.percentage ? 'Percentage' : 'Fixed amount'),
              )
            else
              ShadButton.outline(
                onPressed: () => onCommissionTypeChanged(type),
                child: Text(type == CommissionType.percentage ? 'Percentage' : 'Fixed amount'),
              ),
        ]),
        const SizedBox(height: 8),
        if (commissionType == CommissionType.percentage)
          ShadInput(
              placeholder: const Text('Commission rate %'),
              controller: commissionRateController,
              keyboardType: TextInputType.number)
        else
          ShadInput(
              placeholder: const Text('Fixed commission amount (\$)'),
              controller: commissionFixedAmountController,
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
