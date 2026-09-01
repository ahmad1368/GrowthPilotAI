import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Bulk-tagging form (Issue #342). Returns the new tag assignments (not
/// yet persisted) or null if cancelled/invalid.
Future<List<MerchantTagEntity>?> showMerchantTagDialog(
    BuildContext context, List<MerchantTagSummary> merchants) {
  return showShadDialog<List<MerchantTagEntity>>(
    context: context,
    builder: (context) => MerchantTagDialogContent(merchants: merchants),
  );
}
