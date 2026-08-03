import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Add/edit form for a merchant configuration profile (Issue #338).
/// Pass [existing] to pre-fill and edit that profile in place. Returns
/// the profile to persist (not yet saved) or null if cancelled/invalid.
Future<MerchantConfigEntity?> showMerchantConfigDialog(BuildContext context,
    {MerchantConfigEntity? existing}) {
  return showShadDialog<MerchantConfigEntity>(
    context: context,
    builder: (context) => MerchantConfigDialogContent(existing: existing),
  );
}
