import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a competitor price observation (Issue
/// #351). Returns the new observation (not yet persisted) or null if
/// cancelled/invalid.
Future<CompetitorPriceObservationEntity?> showCompetitorPriceDialog(
    BuildContext context) {
  return showShadDialog<CompetitorPriceObservationEntity>(
    context: context,
    builder: (context) => const CompetitorPriceDialogContent(),
  );
}
