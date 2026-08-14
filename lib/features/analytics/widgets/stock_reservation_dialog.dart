import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_reservation_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Opens the reserve-for-online-checkout dialog (Issue #445). Returns the
/// requested reservation (not yet applied) or null if cancelled/invalid.
Future<StockReservationDraft?> showStockReservationDialog(
    BuildContext context, List<InventoryItemEntity> items) {
  return showShadDialog<StockReservationDraft>(
    context: context,
    builder: (context) => StockReservationDialogContent(items: items),
  );
}
