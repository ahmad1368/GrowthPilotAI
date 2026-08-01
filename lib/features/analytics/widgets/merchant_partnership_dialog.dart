import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a merchant partnership (Issue #393). Returns
/// the new partnership (not yet persisted) or null if cancelled/invalid.
Future<MerchantPartnershipEntity?> showMerchantPartnershipDialog(
    BuildContext context) {
  return showShadDialog<MerchantPartnershipEntity>(
    context: context,
    builder: (context) => const MerchantPartnershipDialogContent(),
  );
}
