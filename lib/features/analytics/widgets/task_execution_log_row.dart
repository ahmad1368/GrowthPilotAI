import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/task_execution_outcome.dart';

/// One read-only execution log entry (Issue #406, acceptance criterion
/// 4) — records status, timestamp, and failure reason for auditing.
class TaskExecutionLogRow extends StatelessWidget {
  final TaskExecutionLogEntity log;

  const TaskExecutionLogRow({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final succeeded = log.outcome == TaskExecutionOutcome.success;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(succeeded ? Icons.check_circle_outline : Icons.error_outline,
              size: 14, color: succeeded ? scheme.primary : Colors.red),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
                '${log.taskName} — attempt ${log.attemptNumber}'
                '${succeeded ? '' : ': ${log.failureReason}'}',
                style: const TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
