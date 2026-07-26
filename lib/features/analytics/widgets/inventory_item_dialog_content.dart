import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/generate_inventory_item_sku.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_item_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_attributes_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_perishable_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showInventoryItemDialog] (Issue #435): owns the
/// name/quantity/reorder-threshold/unit-cost/category/SKU state (category
/// picker in #436, SKU field + generator in #437, expiry/serial/attributes
/// in #438).
class InventoryItemDialogContent extends StatefulWidget {
  final List<InventoryCategoryEntity> categories;
  final List<InventoryItemEntity> existingItems;

  const InventoryItemDialogContent(
      {super.key, required this.categories, required this.existingItems});

  @override
  State<InventoryItemDialogContent> createState() => _InventoryItemDialogContentState();
}

class _InventoryItemDialogContentState extends State<InventoryItemDialogContent> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _reorderThresholdController = TextEditingController();
  final _unitCostController = TextEditingController();
  final _skuController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _attributeKeyControllers = <TextEditingController>[];
  final _attributeValueControllers = <TextEditingController>[];
  InventoryCategoryEntity? _category;
  DateTime? _expiryDate;

  void _generateSku() {
    final existingSkus = widget.existingItems.map((i) => i.sku).toList();
    _skuController.text = GenerateInventoryItemSku.call(_category?.name, existingSkus);
  }

  Future<void> _pickExpiryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  void _addAttributeRow() {
    setState(() {
      _attributeKeyControllers.add(TextEditingController());
      _attributeValueControllers.add(TextEditingController());
    });
  }

  void _removeAttributeRow(int index) {
    setState(() {
      _attributeKeyControllers.removeAt(index);
      _attributeValueControllers.removeAt(index);
    });
  }

  void _submit() {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim());
    final reorderThreshold = int.tryParse(_reorderThresholdController.text.trim());
    final unitCost = double.tryParse(_unitCostController.text.trim());
    if (name.isEmpty || quantity == null || reorderThreshold == null || unitCost == null) {
      return;
    }
    final item = InventoryItemEntity(
      name: name,
      quantityOnHand: quantity,
      reorderThreshold: reorderThreshold,
      unitCost: unitCost,
      sku: _skuController.text.trim(),
      expiryDate: _expiryDate,
      serialNumber: _serialNumberController.text.trim(),
    );
    if (_category != null) item.category.target = _category;

    final attributes = <MapEntry<String, String>>[];
    for (var i = 0; i < _attributeKeyControllers.length; i++) {
      final key = _attributeKeyControllers[i].text.trim();
      final value = _attributeValueControllers[i].text.trim();
      if (key.isNotEmpty && value.isNotEmpty) attributes.add(MapEntry(key, value));
    }

    Navigator.of(context).pop(InventoryItemDraft(item: item, attributes: attributes));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Add Inventory Item'),
      description: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InventoryItemFields(
              nameController: _nameController,
              quantityController: _quantityController,
              reorderThresholdController: _reorderThresholdController,
              unitCostController: _unitCostController,
              skuController: _skuController,
              categories: widget.categories,
              selectedCategory: _category,
              onCategoryChanged: (value) => setState(() => _category = value),
              onGenerateSku: _generateSku,
            ),
            const SizedBox(height: 8),
            InventoryItemPerishableFields(
              expiryDate: _expiryDate,
              onPickExpiryDate: _pickExpiryDate,
              serialNumberController: _serialNumberController,
            ),
            const SizedBox(height: 8),
            InventoryItemAttributesFields(
              keyControllers: _attributeKeyControllers,
              valueControllers: _attributeValueControllers,
              onAddRow: _addAttributeRow,
              onRemoveRow: _removeAttributeRow,
            ),
          ],
        ),
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
