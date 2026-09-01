import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_scheduled_task_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/task_execution_log_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders task rows, an add button, the recent execution log, and a
/// summary narrative (Issue #406). Purely presentational — state is
/// owned by [ScheduledTaskBody].
class ScheduledTaskView extends StatelessWidget {
  final List<ScheduledTaskEntity> tasks;
  final List<TaskExecutionLogEntity> recentLogs;
  final VoidCallback onAddTask;
  final ValueChanged<ScheduledTaskEntity> onRunNow;
  final ValueChanged<ScheduledTaskEntity> onSimulateFailure;

  const ScheduledTaskView({
    super.key,
    required this.tasks,
    required this.recentLogs,
    required this.onAddTask,
    required this.onRunNow,
    required this.onSimulateFailure,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddTask,
              child: Text('+ Schedule Task', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final task in tasks)
          ScheduledTaskRow(
            task: task,
            onRunNow: () => onRunNow(task),
            onSimulateFailure: () => onSimulateFailure(task),
          ),
        const SizedBox(height: 8),
        Text(BuildScheduledTaskNarrative.call(tasks)),
        if (recentLogs.isNotEmpty) ...[
          const SizedBox(height: 8),
          for (final log in recentLogs) TaskExecutionLogRow(log: log),
        ],
      ],
    );
  }
}
