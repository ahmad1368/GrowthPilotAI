import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New campaign composer form (Issue #407). Returns the new draft
/// campaign (not yet persisted) or null if cancelled/invalid.
Future<MarketingCampaignEntity?> showMarketingCampaignDialog(
    BuildContext context) {
  return showShadDialog<MarketingCampaignEntity>(
    context: context,
    builder: (context) => const MarketingCampaignDialogContent(),
  );
}
