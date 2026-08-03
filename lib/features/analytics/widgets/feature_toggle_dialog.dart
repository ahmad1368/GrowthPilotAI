import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Add/edit form for a feature module toggle (Issue #339). Pass
/// [existing] to pre-fill and edit that module in place. Returns the
/// toggle to persist (not yet saved) or null if cancelled/invalid.
Future<FeatureModuleToggleEntity?> showFeatureToggleDialog(BuildContext context,
    {FeatureModuleToggleEntity? existing}) {
  return showShadDialog<FeatureModuleToggleEntity>(
    context: context,
    builder: (context) => FeatureToggleDialogContent(existing: existing),
  );
}
