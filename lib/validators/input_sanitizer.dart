/// Cleans user-supplied strings before they are sent to the API, mirroring the
/// backend's trim + escape sanitization (XSS / NoSQL-injection defense).
class InputSanitizer {
  static final RegExp _htmlTag = RegExp('<[^>]*>');

  /// Trims and strips any HTML/script tags from [input].
  static String clean(String input) => input.replaceAll(_htmlTag, '').trim();

  /// Escapes the HTML-significant characters instead of removing them.
  static String escapeHtml(String input) => input
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
}
