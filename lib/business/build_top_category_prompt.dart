/// Highlights an anomalous or simply top-spend category (Issue #201's
/// "Anomalies... suggest 'Why is my restaurant spending up?'" /
/// "High-Spend Category Detection"). Null when there's no category to
/// point at (caller has no local spend data yet).
class BuildTopCategoryPrompt {
  static String? call({required String? topCategory, double? percentChangeVsLastMonth}) {
    if (topCategory == null) return null;
    if (percentChangeVsLastMonth != null && percentChangeVsLastMonth >= 20) {
      return 'Why is my $topCategory spending up?';
    }
    return 'Why did I spend more on $topCategory?';
  }
}
