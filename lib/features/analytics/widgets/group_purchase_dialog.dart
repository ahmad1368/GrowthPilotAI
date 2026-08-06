import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New group-purchase campaign wizard (Issue #414, acceptance
/// criterion 1). Returns the new campaign (not yet persisted) or null
/// if cancelled/invalid.
Future<GroupPurchaseEntity?> showGroupPurchaseDialog(BuildContext context) {
  return showShadDialog<GroupPurchaseEntity>(
    context: context,
    builder: (context) => const GroupPurchaseDialogContent(),
  );
}
