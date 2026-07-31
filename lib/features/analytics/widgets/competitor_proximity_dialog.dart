import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a new competitor sighting (Issue #374).
/// Returns the new sighting (not yet persisted) or null if
/// cancelled/invalid.
Future<CompetitorSightingEntity?> showCompetitorProximityDialog(
    BuildContext context) {
  return showShadDialog<CompetitorSightingEntity>(
    context: context,
    builder: (context) => const CompetitorProximityDialogContent(),
  );
}
