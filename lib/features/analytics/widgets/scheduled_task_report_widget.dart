import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_body.dart';

/// Registers the Advanced Background Scheduler (Issue #406) as a
/// pluggable report widget under id `SCHEDULED_TASK_ENGINE` (#111).
class ScheduledTaskReportWidget extends BaseReportWidget {
  const ScheduledTaskReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ScheduledTaskBody(
      initialTasks: data['tasks'] as List<ScheduledTaskEntity>,
      initialLogs: data['logs'] as List<TaskExecutionLogEntity>,
    );
  }
}
