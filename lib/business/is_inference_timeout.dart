/// Whether the local SLM's time-to-first-token exceeded the issue's
/// "strict 5-second watchdog timer" (Issue #210).
class IsInferenceTimeout {
  static const limitMs = 5000;

  static bool call(int elapsedMs) => elapsedMs > limitMs;
}
