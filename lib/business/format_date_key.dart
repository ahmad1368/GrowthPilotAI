/// Formats a [DateTime] as a "YYYY-MM-DD" local-date key (Issue #159) —
/// used to detect day rollover for the daily alert cap.
class FormatDateKey {
  static String call(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
