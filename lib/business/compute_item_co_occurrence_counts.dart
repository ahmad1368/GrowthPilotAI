/// Pairwise co-purchase counts across baskets (Issue #378), keyed
/// `"itemA::itemB"` with names alphabetically ordered so each unordered
/// pair only accumulates once.
class ComputeItemCoOccurrenceCounts {
  static Map<String, int> call(List<List<String>> baskets) {
    final counts = <String, int>{};
    for (final basket in baskets) {
      final uniqueItems = basket.toSet().toList()..sort();
      for (var i = 0; i < uniqueItems.length; i++) {
        for (var j = i + 1; j < uniqueItems.length; j++) {
          final key = '${uniqueItems[i]}::${uniqueItems[j]}';
          counts[key] = (counts[key] ?? 0) + 1;
        }
      }
    }
    return counts;
  }
}
