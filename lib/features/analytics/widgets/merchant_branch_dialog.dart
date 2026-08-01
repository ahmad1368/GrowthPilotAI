import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a supervised-branch snapshot (Issue #400).
/// Returns the new branch (not yet persisted) or null if
/// cancelled/invalid.
Future<MerchantBranchEntity?> showMerchantBranchDialog(BuildContext context) {
  return showShadDialog<MerchantBranchEntity>(
    context: context,
    builder: (context) => const MerchantBranchDialogContent(),
  );
}
