import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Add/edit form for a banner matching rule (Issue #403). Pass
/// [existing] to pre-fill and edit that rule in place. Returns the rule
/// to persist (not yet saved) or null if cancelled/invalid.
Future<BannerMatchingRuleEntity?> showBannerRuleDialog(BuildContext context,
    {BannerMatchingRuleEntity? existing}) {
  return showShadDialog<BannerMatchingRuleEntity>(
    context: context,
    builder: (context) => BannerRuleDialogContent(existing: existing),
  );
}
