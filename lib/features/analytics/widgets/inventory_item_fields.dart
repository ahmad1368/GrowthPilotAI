import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/business/build_inventory_category_path.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name/quantity/reorder-threshold/unit-cost/category/SKU inputs for a
/// new inventory item (Issue #435, category picker in #436, SKU field +
/// generator in #437).
class InventoryItemFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController reorderThresholdController;
  final TextEditingController unitCostController;
  final TextEditingController skuController;
  final List<InventoryCategoryEntity> categories;
  final InventoryCategoryEntity? selectedCategory;
  final ValueChanged<InventoryCategoryEntity?> onCategoryChanged;
  final VoidCallback onGenerateSku;

  const InventoryItemFields({
    super.key,
    required this.nameController,
    required this.quantityController,
    required this.reorderThresholdController,
    required this.unitCostController,
    required this.skuController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onGenerateSku,
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
        const SizedBox(height: 8),
        ShadSelect<InventoryCategoryEntity?>(
          initialValue: selectedCategory,
          placeholder: const Text('Category (optional)'),
          options: [
            const ShadOption(value: null, child: Text('None')),
            for (final c in categories)
              ShadOption(value: c, child: Text(BuildInventoryCategoryPath.call(c))),
          ],
          selectedOptionBuilder: (context, value) =>
              Text(value == null ? 'None' : BuildInventoryCategoryPath.call(value)),
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ShadInput(placeholder: const Text('SKU (optional)'), controller: skuController),
            ),
            const SizedBox(width: 8),
            ShadButton.outline(onPressed: onGenerateSku, child: const Text('Generate')),
          ],
        ),
      ],
    );
  }
}
