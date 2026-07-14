/// Sørensen–Dice bigram similarity, 0.0 (no overlap) to 1.0 (identical) —
/// used by [AccountFuzzyMatcher] instead of pulling in a similarity package.
class StringSimilarity {
  static double compare(String a, String b) {
    final x = a.toLowerCase();
    final y = b.toLowerCase();
    if (x == y) return 1.0;
    if (x.length < 2 || y.length < 2) return 0.0;

    final bigramsX = _bigrams(x);
    final bigramsY = _bigrams(y);
    var matches = 0;
    final remaining = List<String>.from(bigramsY);
    for (final bg in bigramsX) {
      final index = remaining.indexOf(bg);
      if (index != -1) {
        matches++;
        remaining.removeAt(index);
      }
    }
    return (2.0 * matches) / (bigramsX.length + bigramsY.length);
  }

  static List<String> _bigrams(String s) =>
      List.generate(s.length - 1, (i) => s.substring(i, i + 2));
}
