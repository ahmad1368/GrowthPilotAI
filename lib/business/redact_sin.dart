/// Redacts Canadian Social Insurance Numbers (Issue #88 AC 1) — format
/// `###-###-###`.
class RedactSin {
  static final _sinPattern = RegExp(r'\b\d{3}-\d{3}-\d{3}\b');

  static String call(String text) => text.replaceAll(_sinPattern, '[REDACTED_SIN]');
}
