import 'package:growth_pilot_ai/business/compute_next_run_time.dart';
import 'package:growth_pilot_ai/business/compute_retry_backoff.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/task_execution_outcome.dart';

/// Runs one dispatch attempt for a scheduled task (Issue #406,
/// acceptance criteria 1-4) — this app has no SMTP/email backend, so
/// dispatch success is simulated; a successful run resets retries and
/// reschedules on the normal interval, a failed run applies exponential
/// backoff instead. Either outcome is recorded to the immutable
/// execution log.
class ExecuteScheduledTask {
  static ({ScheduledTaskEntity task, TaskExecutionLogEntity log}) call(
      ScheduledTaskEntity task, DateTime now, {required bool succeeded, String failureReason = ''}) {
    final attemptNumber = task.retryCount + 1;

    final updatedTask = ScheduledTaskEntity(
      id: task.id,
      taskName: task.taskName,
      targetSegment: task.targetSegment,
      intervalMinutes: task.intervalMinutes,
      lastRunAt: now,
      nextRunAt: succeeded
          ? ComputeNextRunTime.call(now, task.intervalMinutes)
          : now.add(ComputeRetryBackoff.call(attemptNumber)),
      retryCount: succeeded ? 0 : attemptNumber,
      maxRetries: task.maxRetries,
      updatedAt: now,
    );

    final log = TaskExecutionLogEntity(
      taskName: task.taskName,
      executedAt: now,
      dbOutcome: (succeeded ? TaskExecutionOutcome.success : TaskExecutionOutcome.failure).index,
      failureReason: succeeded ? '' : failureReason,
      attemptNumber: attemptNumber,
    );

    return (task: updatedTask, log: log);
  }
}
