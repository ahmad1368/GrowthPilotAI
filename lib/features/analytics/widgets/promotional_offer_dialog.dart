import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a promotional offer dispatch (Issue #335).
/// Returns the new offer (not yet persisted) or null if
/// cancelled/invalid.
Future<PromotionalOfferEntity?> showPromotionalOfferDialog(
    BuildContext context) {
  return showShadDialog<PromotionalOfferEntity>(
    context: context,
    builder: (context) => const PromotionalOfferDialogContent(),
  );
}
