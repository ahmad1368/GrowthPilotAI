import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a neighborhood expansion evaluation
/// (Issue #372). Returns the new evaluation (not yet persisted) or null
/// if cancelled/invalid.
Future<NeighborhoodExpansionEntity?> showNeighborhoodExpansionDialog(
    BuildContext context) {
  return showShadDialog<NeighborhoodExpansionEntity>(
    context: context,
    builder: (context) => const NeighborhoodExpansionDialogContent(),
  );
}
