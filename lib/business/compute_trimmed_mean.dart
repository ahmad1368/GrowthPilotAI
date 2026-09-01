/// "Outlier Suppression" (Issue #82 scope item 2): excludes the top and
/// bottom [trimPercent] of sorted [values] before averaging, so a single
/// "whale" business doesn't skew a small-business sector benchmark. Falls
/// back to the untrimmed average when the sample is too small for
/// trimming to remove anything.
class ComputeTrimmedMean {
  static double call(List<double> values, {double trimPercent = 0.05}) {
    if (values.isEmpty) return 0;
    final sorted = List<double>.of(values)..sort();
    final trimCount = (sorted.length * trimPercent).floor();
    final trimmed = trimCount * 2 >= sorted.length
        ? sorted
        : sorted.sublist(trimCount, sorted.length - trimCount);
    return trimmed.reduce((a, b) => a + b) / trimmed.length;
  }
}
