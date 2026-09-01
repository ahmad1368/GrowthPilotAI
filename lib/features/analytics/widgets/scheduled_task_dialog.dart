import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New scheduled task form (Issue #406). Returns the task (not yet
/// persisted) or null if cancelled/invalid.
Future<ScheduledTaskEntity?> showScheduledTaskDialog(BuildContext context) {
  return showShadDialog<ScheduledTaskEntity>(
    context: context,
    builder: (context) => const ScheduledTaskDialogContent(),
  );
}
