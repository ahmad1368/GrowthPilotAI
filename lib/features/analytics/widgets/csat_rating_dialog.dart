import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_rating_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a CSAT rating (Issue #375). Returns the new
/// rating (not yet persisted) or null if cancelled/invalid.
Future<CsatRatingEntity?> showCsatRatingDialog(BuildContext context) {
  return showShadDialog<CsatRatingEntity>(
    context: context,
    builder: (context) => const CsatRatingDialogContent(),
  );
}
