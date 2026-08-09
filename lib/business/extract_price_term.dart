/// Parses the "Final Price" out of a chat message (Issue #152) — reuses
/// #128's `DetectFinancialTag` precision-tuned pattern, but returns the
/// actual numeric value instead of just a presence flag.
class ExtractPriceTerm {
  static final _pattern = RegExp(r'\$\s?(\d+(?:\.\d{2})?)|\b(\d+\.\d{2})\b');

  static double? call(String content) {
    final match = _pattern.firstMatch(content);
    if (match == null) return null;
    return double.tryParse(match.group(1) ?? match.group(2)!);
  }
}
