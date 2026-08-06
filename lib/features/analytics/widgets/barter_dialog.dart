import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New barter listing wizard (Issue #413, acceptance criterion 1).
/// Returns the new listing (not yet persisted) or null if
/// cancelled/invalid.
Future<BarterListingEntity?> showBarterDialog(BuildContext context) {
  return showShadDialog<BarterListingEntity>(
    context: context,
    builder: (context) => const BarterDialogContent(),
  );
}
