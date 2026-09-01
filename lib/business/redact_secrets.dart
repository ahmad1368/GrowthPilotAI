/// Redacts common secret-looking `key: value` pairs (Issue #206's
/// "Secret Scanning" objective, reinterpreted for this local-first app
/// — no CI/git-secrets pipeline exists here, but any password/token/API
/// key that ends up in a log message shouldn't be persisted in the
/// clear). Same pattern set as [RedactSensitiveSupportInfo] (Issue
/// #193), kept as its own file since that one is scoped to support-chat
/// text and this one is a general-purpose text redactor.
class RedactSecrets {
  static final _patterns = [
    RegExp(r'(password|passwd|pwd)\s*[:=]\s*\S+', caseSensitive: false),
    RegExp(r'(token|api[_ ]?key|secret)\s*[:=]\s*\S+', caseSensitive: false),
  ];

  static String call(String text) {
    var redacted = text;
    for (final pattern in _patterns) {
      redacted = redacted.replaceAllMapped(pattern, (match) => '${match.group(1)}: [REDACTED]');
    }
    return redacted;
  }
}
