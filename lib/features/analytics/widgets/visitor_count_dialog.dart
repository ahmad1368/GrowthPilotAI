import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/visitor_count_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a daily visitor count (Issue #387).
/// Returns the new count (not yet persisted) or null if
/// cancelled/invalid.
Future<VisitorCountEntity?> showVisitorCountDialog(BuildContext context) {
  return showShadDialog<VisitorCountEntity>(
    context: context,
    builder: (context) => const VisitorCountDialogContent(),
  );
}
