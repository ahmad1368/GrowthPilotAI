import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for an inventory item (Issue #435). Returns the new item
/// (not yet persisted) or null if cancelled/invalid.
Future<InventoryItemEntity?> showInventoryItemDialog(
    BuildContext context, List<InventoryCategoryEntity> categories) {
  return showShadDialog<InventoryItemEntity>(
    context: context,
    builder: (context) => InventoryItemDialogContent(categories: categories),
  );
}
