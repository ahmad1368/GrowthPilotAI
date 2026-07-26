import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_take_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for a stock-take audit (Issue #441). Returns the new
/// draft (not yet persisted) or null if cancelled/invalid.
Future<StockTakeDraft?> showStockTakeDialog(BuildContext context, List<InventoryItemEntity> items) {
  return showShadDialog<StockTakeDraft>(
    context: context,
    builder: (context) => StockTakeDialogContent(items: items),
  );
}
