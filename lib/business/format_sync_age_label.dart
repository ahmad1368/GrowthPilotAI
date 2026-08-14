/// Human-friendly "time since last sync" label for the Offline
/// Intelligence badge (Issue #109) — a plain relative-age string, matching
/// [PackSyncStatusBadge]'s (#86) day-count style rather than pulling in a
/// full timeago package for one label.
class FormatSyncAgeLabel {
  static String call(DateTime lastSyncedAt, DateTime now) {
    final diff = now.difference(lastSyncedAt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
