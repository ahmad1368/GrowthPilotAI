/// Parses a plain-language quantity out of a chat message (Issue #152)
/// — e.g. "10 units", "5 boxes", "qty 20", "20x".
class ExtractQuantityTerm {
  static final _pattern =
      RegExp(r'\b(\d+)\s?(?:units?|boxes|pcs|pieces|x)\b|\bqty\.?\s*(\d+)\b', caseSensitive: false);

  static int? call(String content) {
    final match = _pattern.firstMatch(content);
    if (match == null) return null;
    return int.tryParse(match.group(1) ?? match.group(2)!);
  }
}
