import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging an ad campaign (Issue #366). Returns the
/// new campaign (not yet persisted) or null if cancelled/invalid.
Future<AdCampaignEntity?> showAdCampaignDialog(BuildContext context) {
  return showShadDialog<AdCampaignEntity>(
    context: context,
    builder: (context) => const AdCampaignDialogContent(),
  );
}
