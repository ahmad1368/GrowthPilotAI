/// The 30-day recovery window before a soft-deleted record is permanently
/// purged (data-minimization). Drives both the "restore within N days" UI and
/// the client's view of what the retention worker will hard-delete.
class RetentionPolicy {
  static const Duration window = Duration(days: 30);

  /// True once a soft-deleted record has aged past the retention window.
  static bool isPurgeable(DateTime? deletedAt, DateTime now) =>
      deletedAt != null && now.difference(deletedAt) > window;

  /// Time left before permanent deletion: [Duration.zero] if past due, or null
  /// when the record has not been soft-deleted.
  static Duration? remaining(DateTime? deletedAt, DateTime now) {
    if (deletedAt == null) return null;
    final left = window - now.difference(deletedAt);
    return left.isNegative ? Duration.zero : left;
  }
}
