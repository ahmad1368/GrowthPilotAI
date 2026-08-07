/// CRA's statutory record-keeping period for business tax records
/// (Issue #428, acceptance criterion 4) — six years, distinct from
/// [RetentionPolicy]'s unrelated 30-day soft-delete window (#53);
/// this only computes status for display, it never auto-deletes
/// financial records.
class ComputeCraRetentionStatus {
  static const statutoryPeriod = Duration(days: 365 * 6);

  static bool isWithinStatutoryPeriod(DateTime loggedAt, DateTime now) =>
      now.difference(loggedAt) <= statutoryPeriod;

  static Duration remaining(DateTime loggedAt, DateTime now) {
    final left = statutoryPeriod - now.difference(loggedAt);
    return left.isNegative ? Duration.zero : left;
  }
}
