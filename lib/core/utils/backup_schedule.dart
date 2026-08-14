/// Client-side view of the nightly backup cadence (the backend cron runs the
/// dump at [hourOfDay]). Lets the UI show the next scheduled backup and flag
/// when a backup is overdue.
class BackupSchedule {
  final int hourOfDay;

  const BackupSchedule({this.hourOfDay = 3});

  /// The next time a backup is scheduled to run, strictly after [from].
  DateTime nextRunAfter(DateTime from) {
    final today = DateTime(from.year, from.month, from.day, hourOfDay);
    return today.isAfter(from)
        ? today
        : DateTime(from.year, from.month, from.day + 1, hourOfDay);
  }

  /// A backup is overdue if none has run within ~a day (plus [grace]) of [now].
  bool isOverdue(
    DateTime? lastBackupAt,
    DateTime now, {
    Duration grace = const Duration(hours: 2),
  }) {
    if (lastBackupAt == null) return true;
    return now.difference(lastBackupAt) > const Duration(hours: 24) + grace;
  }
}
