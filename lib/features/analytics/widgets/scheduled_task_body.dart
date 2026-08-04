import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/execute_scheduled_task.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/scheduled_task_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/task_execution_log_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_view.dart';

/// Owns the scheduled task list and execution log (Issue #406),
/// persisting add/run/failure-simulation actions immediately.
class ScheduledTaskBody extends StatefulWidget {
  final List<ScheduledTaskEntity> initialTasks;
  final List<TaskExecutionLogEntity> initialLogs;

  const ScheduledTaskBody(
      {super.key, required this.initialTasks, required this.initialLogs});

  @override
  State<ScheduledTaskBody> createState() => _ScheduledTaskBodyState();
}

class _ScheduledTaskBodyState extends State<ScheduledTaskBody> {
  late List<ScheduledTaskEntity> _tasks = widget.initialTasks;
  late List<TaskExecutionLogEntity> _logs = widget.initialLogs;

  Future<void> _addTask() async {
    final task = await showScheduledTaskDialog(context);
    if (task == null) return;
    final savedId = ScheduledTaskRepository(
            Get.find<ObjectBox>().store.box<ScheduledTaskEntity>())
        .save(task);
    setState(() => _tasks = [
          ..._tasks,
          ScheduledTaskEntity(
              id: savedId,
              taskName: task.taskName,
              targetSegment: task.targetSegment,
              intervalMinutes: task.intervalMinutes,
              nextRunAt: task.nextRunAt,
              updatedAt: task.updatedAt),
        ]);
  }

  void _run(ScheduledTaskEntity task, {required bool succeeded}) {
    final store = Get.find<ObjectBox>().store;
    final result = ExecuteScheduledTask.call(task, DateTime.now(),
        succeeded: succeeded, failureReason: succeeded ? '' : 'Simulated SMTP timeout');
    ScheduledTaskRepository(store.box<ScheduledTaskEntity>()).save(result.task);
    TaskExecutionLogRepository(store.box<TaskExecutionLogEntity>()).record(result.log);
    setState(() {
      _tasks = [
        for (final t in _tasks)
          if (t.id != result.task.id) t,
        result.task,
      ];
      _logs = [..._logs, result.log];
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentLogs = _logs.reversed.take(5).toList();
    return ScheduledTaskView(
      tasks: _tasks,
      recentLogs: recentLogs,
      onAddTask: _addTask,
      onRunNow: (task) => _run(task, succeeded: true),
      onSimulateFailure: (task) => _run(task, succeeded: false),
    );
  }
}
