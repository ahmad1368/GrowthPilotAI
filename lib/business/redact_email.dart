/// Redacts email addresses (Issue #88, mirrors the issue's own
/// `PiiScrubberService` pattern list).
class RedactEmail {
  static final _emailPattern = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

  static String call(String text) => text.replaceAll(_emailPattern, '[REDACTED_EMAIL]');
}
