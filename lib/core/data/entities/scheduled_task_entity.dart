import 'package:objectbox/objectbox.dart';

/// An admin-configured recurring marketing/email dispatch task (Issue
/// #406) — this app has no distributed task queue or SMTP backend, so
/// scheduling and dispatch are simulated locally: [intervalMinutes] is
/// a simplified stand-in for full cron expressions, and admins can
/// still trigger a manual run (acceptance criterion 1) alongside the
/// recurring schedule (acceptance criterion 2).
@Entity()
class ScheduledTaskEntity {
  @Id()
  int id = 0;

  String taskName;

  String targetSegment;

  int intervalMinutes;

  @Property(type: PropertyType.date)
  DateTime? lastRunAt;

  @Index()
  @Property(type: PropertyType.date)
  DateTime nextRunAt;

  int retryCount;

  int maxRetries;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  ScheduledTaskEntity({
    this.id = 0,
    required this.taskName,
    required this.targetSegment,
    required this.intervalMinutes,
    this.lastRunAt,
    required this.nextRunAt,
    this.retryCount = 0,
    this.maxRetries = 3,
    required this.updatedAt,
  });
}
