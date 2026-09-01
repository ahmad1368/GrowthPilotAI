import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/execute_scheduled_task.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/enum/task_execution_outcome.dart';

ScheduledTaskEntity _task({int retryCount = 0, int intervalMinutes = 60}) =>
    ScheduledTaskEntity(
      id: 1,
      taskName: 'Weekly digest email',
      targetSegment: 'all_merchants',
      intervalMinutes: intervalMinutes,
      nextRunAt: DateTime(2026, 1, 1),
      retryCount: retryCount,
      updatedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('a successful run reschedules on the normal interval and resets retries', () {
    final now = DateTime(2026, 1, 8, 9);
    final task = _task(retryCount: 2, intervalMinutes: 120);

    final result = ExecuteScheduledTask.call(task, now, succeeded: true);

    expect(result.task.retryCount, 0);
    expect(result.task.nextRunAt, now.add(const Duration(minutes: 120)));
    expect(result.task.lastRunAt, now);
    expect(result.log.dbOutcome, TaskExecutionOutcome.success.index);
    expect(result.log.failureReason, '');
    expect(result.log.attemptNumber, 3);
  });

  test('a failed run applies exponential backoff and increments retryCount', () {
    final now = DateTime(2026, 1, 8, 9);
    final task = _task(retryCount: 1);

    final result = ExecuteScheduledTask.call(task, now,
        succeeded: false, failureReason: 'Simulated SMTP timeout');

    expect(result.task.retryCount, 2);
    expect(result.task.nextRunAt, now.add(const Duration(minutes: 4)));
    expect(result.log.dbOutcome, TaskExecutionOutcome.failure.index);
    expect(result.log.failureReason, 'Simulated SMTP timeout');
    expect(result.log.attemptNumber, 2);
  });

  test('logged attemptNumber and taskName always mirror the task being executed', () {
    final task = _task(retryCount: 0);

    final result = ExecuteScheduledTask.call(task, DateTime(2026, 1, 1),
        succeeded: true);

    expect(result.log.taskName, task.taskName);
    expect(result.log.attemptNumber, 1);
  });
}
