/// Output of [ApplyKAnonymity]: the surviving records plus how many were
/// suppressed, for the "log the number of suppressed records" AC.
class KAnonymityResult<T> {
  final List<T> data;
  final int suppressedCount;

  const KAnonymityResult(this.data, this.suppressedCount);
}

/// K-Anonymity suppression (Issue #90) — groups [data] by [groupKey] (a
/// combination of generalized quasi-identifiers, e.g. region+decade) and
/// drops any group smaller than [k], so no released record's combination
/// of traits is unique to fewer than [k] individuals.
class ApplyKAnonymity {
  static KAnonymityResult<T> call<T>(
    List<T> data,
    String Function(T) groupKey, {
    int k = 5,
  }) {
    final groups = <String, List<T>>{};
    for (final item in data) {
      groups.putIfAbsent(groupKey(item), () => []).add(item);
    }

    final survivors = <T>[];
    var suppressedCount = 0;
    for (final group in groups.values) {
      if (group.length >= k) {
        survivors.addAll(group);
      } else {
        suppressedCount += group.length;
      }
    }
    return KAnonymityResult(survivors, suppressedCount);
  }
}
