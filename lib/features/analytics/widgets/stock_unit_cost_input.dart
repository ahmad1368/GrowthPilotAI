import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Decimal unit-cost field for recording an inventory cost layer (Issue
/// #446), mirroring [InventoryItemFields]'s unit-cost input.
class StockUnitCostInput extends StatelessWidget {
  final TextEditingController controller;

  const StockUnitCostInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Unit cost'),
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
    );
  }
}
