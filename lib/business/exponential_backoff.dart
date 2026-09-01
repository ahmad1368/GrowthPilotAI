/// Retry delay for the accounting export push (Issue #59) — doubles each
/// attempt starting at 2s, capped at 60s, so a QBO/Xero outage doesn't hammer
/// their rate limits (e.g. QuickBooks' 100 requests/minute).
class ExponentialBackoff {
  static const _base = Duration(seconds: 2);
  static const _cap = Duration(seconds: 60);

  /// [attempt] is 0-indexed: 0 -> 2s, 1 -> 4s, 2 -> 8s, ... capped at 60s.
  static Duration delayFor(int attempt) {
    final ms = _base.inMilliseconds * (1 << attempt);
    return Duration(milliseconds: ms.clamp(0, _cap.inMilliseconds));
  }

  static bool shouldRetry(int attempt, {int maxAttempts = 5}) =>
      attempt < maxAttempts;
}
