import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_movement_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Opens the record-stock-movement dialog (Issue #439). Returns the
/// requested movement (not yet applied) or null if cancelled/invalid.
Future<StockMovementDraft?> showStockMovementDialog(
    BuildContext context, List<InventoryItemEntity> items) {
  return showShadDialog<StockMovementDraft>(
    context: context,
    builder: (context) => StockMovementDialogContent(items: items),
  );
}
