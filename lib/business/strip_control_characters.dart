/// "Remove non-printable characters and control codes (e.g. \f, \v, \b)"
/// (Issue #227) — strips ASCII control codes except the newline/tab
/// characters that carry real document structure.
class StripControlCharacters {
  static final _controlChars = RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]');

  static String call(String text) => text.replaceAll(_controlChars, '');
}
