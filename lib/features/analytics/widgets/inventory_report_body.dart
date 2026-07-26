import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_category_repository.dart';
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

  const InventoryReportBody(
      {super.key, required this.initialItems, required this.initialCategories});

  @override
  State<InventoryReportBody> createState() => _InventoryReportBodyState();
}

class _InventoryReportBodyState extends State<InventoryReportBody> {
  late List<InventoryItemEntity> _items = widget.initialItems;
  late List<InventoryCategoryEntity> _categories = widget.initialCategories;

  Future<void> _addItem() async {
    final item = await showInventoryItemDialog(context, _categories, _items);
    if (item == null) return;
    InventoryItemRepository(Get.find<ObjectBox>().store.box<InventoryItemEntity>())
        .insert(item);
    setState(() => _items = [..._items, item]);
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
