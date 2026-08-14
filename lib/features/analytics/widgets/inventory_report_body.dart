import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_attribute_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_category_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_item_attribute_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_item_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_category_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_view.dart';

/// Owns the inventory item + category lists (Issue #435, categories in
/// #436), refreshing them locally after each quick-add insert. Rendering
/// itself is [InventoryReportView]'s job.
class InventoryReportBody extends StatefulWidget {
  final List<InventoryItemEntity> initialItems;
  final List<InventoryCategoryEntity> initialCategories;
  final List<VendorEntity> vendors;

  const InventoryReportBody(
      {super.key,
      required this.initialItems,
      required this.initialCategories,
      required this.vendors});

  @override
  State<InventoryReportBody> createState() => _InventoryReportBodyState();
}

class _InventoryReportBodyState extends State<InventoryReportBody> {
  late List<InventoryItemEntity> _items = widget.initialItems;
  late List<InventoryCategoryEntity> _categories = widget.initialCategories;

  Future<void> _addItem() async {
    final draft = await showInventoryItemDialog(context, _categories, _items, widget.vendors);
    if (draft == null) return;
    final store = Get.find<ObjectBox>().store;
    InventoryItemRepository(store.box<InventoryItemEntity>()).insert(draft.item);

    final attributeRepo =
        InventoryItemAttributeRepository(store.box<InventoryItemAttributeEntity>());
    for (final entry in draft.attributes) {
      final attribute = InventoryItemAttributeEntity(key: entry.key, value: entry.value)
        ..item.target = draft.item;
      attributeRepo.insert(attribute);
    }

    setState(() => _items = [..._items, draft.item]);
  }

  Future<void> _addCategory() async {
    final category = await showInventoryCategoryDialog(context, _categories);
    if (category == null) return;
    InventoryCategoryRepository(Get.find<ObjectBox>().store.box<InventoryCategoryEntity>())
        .insert(category);
    setState(() => _categories = [..._categories, category]);
  }

  @override
  Widget build(BuildContext context) => InventoryReportView(
      items: _items, onAddItem: _addItem, onAddCategory: _addCategory);
}
