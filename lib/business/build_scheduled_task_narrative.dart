import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';

/// One-sentence read naming how many scheduled tasks are currently
/// retrying after a failure (Issue #406).
class BuildScheduledTaskNarrative {
  static String call(List<ScheduledTaskEntity> tasks) {
    if (tasks.isEmpty) {
      return 'No scheduled tasks configured yet.';
    }
    final retrying = tasks.where((t) => t.retryCount > 0).length;
    if (retrying == 0) {
      return 'All ${tasks.length} scheduled task(s) are running normally.';
    }
    return '$retrying of ${tasks.length} scheduled task(s) are retrying after a failed dispatch.';
  }
}
