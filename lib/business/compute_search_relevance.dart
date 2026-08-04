/// Keyword relevance score between a candidate label and the user's
/// query (Issue #404, acceptance criterion 3) — 0 means no match, so
/// sponsored results never get injected for an unrelated query
/// (preserving trust/relevance rather than forcing exposure).
class ComputeSearchRelevance {
  static double call(String candidateText, String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return 0;
    final haystack = candidateText.toLowerCase();
    if (haystack.startsWith(needle)) return 1.0;
    if (haystack.contains(needle)) return 0.6;
    return 0;
  }
}
