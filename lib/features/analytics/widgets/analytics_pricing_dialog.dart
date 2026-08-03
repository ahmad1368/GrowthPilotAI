import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging an advanced-analytics pricing tier
/// assignment (Issue #336). Returns the new tier record (not yet
/// persisted) or null if cancelled/invalid.
Future<AnalyticsPricingTierEntity?> showAnalyticsPricingDialog(
    BuildContext context) {
  return showShadDialog<AnalyticsPricingTierEntity>(
    context: context,
    builder: (context) => const AnalyticsPricingDialogContent(),
  );
}
