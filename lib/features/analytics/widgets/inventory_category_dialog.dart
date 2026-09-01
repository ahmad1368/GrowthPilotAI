import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_category_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for an inventory category (Issue #436). Returns the new
/// category (not yet persisted) or null if cancelled/invalid.
Future<InventoryCategoryEntity?> showInventoryCategoryDialog(
    BuildContext context, List<InventoryCategoryEntity> existingCategories) {
  return showShadDialog<InventoryCategoryEntity>(
    context: context,
    builder: (context) =>
        InventoryCategoryDialogContent(existingCategories: existingCategories),
  );
}
