import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One scheduled task row (Issue #406) — "Run Now" simulates a manual
/// dispatch (acceptance criterion 1) and "Simulate Failure" exercises
/// the retry/backoff path (acceptance criterion 3) for admin testing,
/// since this app has no real SMTP backend to fail on its own.
class ScheduledTaskRow extends StatelessWidget {
  final ScheduledTaskEntity task;
  final VoidCallback onRunNow;
  final VoidCallback onSimulateFailure;

  const ScheduledTaskRow({
    super.key,
    required this.task,
    required this.onRunNow,
    required this.onSimulateFailure,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${task.taskName} → ${task.targetSegment}',
                  overflow: TextOverflow.ellipsis)),
          if (task.retryCount > 0)
            Text('retry ${task.retryCount}/${task.maxRetries}',
                style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 8),
          ShadButton.ghost(onPressed: onRunNow, child: const Text('Run Now')),
          ShadButton.ghost(onPressed: onSimulateFailure, child: const Text('Simulate Failure')),
        ],
      ),
    );
  }
}
