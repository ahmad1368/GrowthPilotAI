/// "PII (Passwords/Tokens) is strictly filtered and NEVER sent to the
/// chat provider" (Issue #193 AC) — redacts common secret-looking
/// `key: value` patterns before a message is stored/"sent" in the
/// local mock support chat.
class RedactSensitiveSupportInfo {
  static final _patterns = [
    RegExp(r'(password|passwd|pwd)\s*[:=]\s*\S+', caseSensitive: false),
    RegExp(r'(token|api[_ ]?key|secret)\s*[:=]\s*\S+', caseSensitive: false),
  ];

  static String call(String message) {
    var redacted = message;
    for (final pattern in _patterns) {
      redacted = redacted.replaceAllMapped(pattern, (match) => '${match.group(1)}: [REDACTED]');
    }
    return redacted;
  }
}
