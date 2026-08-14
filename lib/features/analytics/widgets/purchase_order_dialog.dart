import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/models/purchase_order_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Review dialog for an auto-generated purchase-order draft (Issue #443).
/// Returns the new order (not yet persisted) or null if cancelled/invalid.
Future<PurchaseOrderEntity?> showPurchaseOrderDialog(BuildContext context, PurchaseOrderDraft draft) {
  return showShadDialog<PurchaseOrderEntity>(
    context: context,
    builder: (context) => PurchaseOrderDialogContent(draft: draft),
  );
}
