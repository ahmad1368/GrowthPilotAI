import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_cost_layer_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_cost_layer_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Opens the record-cost-layer dialog (Issue #446). Returns the requested
/// layer (not yet applied) or null if cancelled/invalid.
Future<InventoryCostLayerDraft?> showInventoryCostLayerDialog(
    BuildContext context, List<InventoryItemEntity> items) {
  return showShadDialog<InventoryCostLayerDraft>(
    context: context,
    builder: (context) => InventoryCostLayerDialogContent(items: items),
  );
}
