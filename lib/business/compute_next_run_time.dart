/// The next scheduled run time for a recurring task (Issue #406,
/// acceptance criterion 2) — this app has no cron-expression parser, so
/// a fixed interval stands in for a full cron schedule.
class ComputeNextRunTime {
  static DateTime call(DateTime from, int intervalMinutes) {
    return from.add(Duration(minutes: intervalMinutes));
  }
}
