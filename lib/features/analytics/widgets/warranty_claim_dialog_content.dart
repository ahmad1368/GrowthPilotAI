import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_claim_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showWarrantyClaimDialog] (Issue #389): owns
/// the text controllers.
class WarrantyClaimDialogContent extends StatefulWidget {
  const WarrantyClaimDialogContent({super.key});

  @override
  State<WarrantyClaimDialogContent> createState() =>
      _WarrantyClaimDialogContentState();
}

class _WarrantyClaimDialogContentState extends State<WarrantyClaimDialogContent> {
  final _itemNameController = TextEditingController();
  final _claimCostController = TextEditingController();
  final _coverageRevenueController = TextEditingController();

  void _submit() {
    final claimCost = double.tryParse(_claimCostController.text);
    final coverageRevenue = double.tryParse(_coverageRevenueController.text);
    if (_itemNameController.text.trim().isEmpty ||
        claimCost == null ||
        claimCost < 0 ||
        coverageRevenue == null ||
        coverageRevenue < 0) {
      return;
    }
    Navigator.of(context).pop(WarrantyClaimEntity(
      itemName: _itemNameController.text.trim(),
      claimCost: claimCost,
      coverageRevenue: coverageRevenue,
      date: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Warranty Claim'),
      description: WarrantyClaimFields(
        itemNameController: _itemNameController,
        claimCostController: _claimCostController,
        coverageRevenueController: _coverageRevenueController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
