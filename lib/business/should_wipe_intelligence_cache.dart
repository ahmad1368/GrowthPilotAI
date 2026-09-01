/// "Auto-Wipe Policy" Kill Switch (Issue #106 scope item 4): wipes the
/// local cache once too many consecutive integrity checks fail in a
/// row — a signal of brute-force tampering rather than a one-off
/// corrupt read.
class ShouldWipeIntelligenceCache {
  static const maxConsecutiveFailures = 3;

  static bool call(int consecutiveIntegrityFailures) =>
      consecutiveIntegrityFailures >= maxConsecutiveFailures;
}
