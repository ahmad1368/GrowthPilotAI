import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a discount campaign (Issue #362). Returns
/// the new campaign (not yet persisted) or null if cancelled/invalid.
Future<DiscountCampaignEntity?> showDiscountCampaignDialog(BuildContext context) {
  return showShadDialog<DiscountCampaignEntity>(
    context: context,
    builder: (context) => const DiscountCampaignDialogContent(),
  );
}
