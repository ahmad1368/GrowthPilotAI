import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name/quantity/reorder-threshold/unit-cost inputs for a new inventory
/// item (Issue #435).
class InventoryItemFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController reorderThresholdController;
  final TextEditingController unitCostController;

  const InventoryItemFields({
    super.key,
    required this.nameController,
    required this.quantityController,
    required this.reorderThresholdController,
    required this.unitCostController,
  });

  @override
  Widget build(BuildContext context) {
    final digitsOnly = [FilteringTextInputFormatter.digitsOnly];
    final decimalOnly = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Item name'), controller: nameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Quantity on hand'),
            controller: quantityController,
            keyboardType: TextInputType.number,
            inputFormatters: digitsOnly),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Reorder threshold'),
            controller: reorderThresholdController,
            keyboardType: TextInputType.number,
            inputFormatters: digitsOnly),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Unit cost'),
            controller: unitCostController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: decimalOnly),
      ],
    );
  }
}
