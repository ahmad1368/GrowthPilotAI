import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/task_execution_outcome.dart';

/// One immutable record of a scheduled task execution attempt (Issue
/// #406, acceptance criterion 4) — [TaskExecutionLogRepository] exposes
/// no update/delete so the audit trail can never be altered after the
/// fact, mirroring [AuditLogRepository]'s pattern.
@Entity()
class TaskExecutionLogEntity {
  @Id()
  int id = 0;

  @Index()
  String taskName;

  @Property(type: PropertyType.date)
  DateTime executedAt;

  int dbOutcome; // TaskExecutionOutcome index

  String failureReason;

  int attemptNumber;

  TaskExecutionLogEntity({
    this.id = 0,
    required this.taskName,
    required this.executedAt,
    this.dbOutcome = 0, // TaskExecutionOutcome.success
    this.failureReason = '',
    required this.attemptNumber,
  });

  TaskExecutionOutcome get outcome => TaskExecutionOutcome.values[dbOutcome];
  set outcome(TaskExecutionOutcome value) => dbOutcome = value.index;
}
