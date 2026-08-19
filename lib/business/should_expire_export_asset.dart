/// "Configure an S3 Lifecycle Policy so that files... are automatically
/// deleted after 24-48 hours" (Issue #253) — the local equivalent:
/// past this window a stored export's bytes are treated as
/// unavailable for re-share (the audit record itself is never
/// deleted, preserving #250's WORM guarantee; see PR notes).
class ShouldExpireExportAsset {
  static bool call(DateTime occurredAt, DateTime now, {Duration ttl = const Duration(hours: 48)}) {
    return now.difference(occurredAt) > ttl;
  }
}
