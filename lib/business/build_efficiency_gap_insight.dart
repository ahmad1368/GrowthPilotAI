/// "Actionable Insight" string (Issue #100 scope item 4: "You could
/// save 15% by driving 5 minutes further.") — null when either figure
/// isn't available, rather than showing a misleading placeholder.
class BuildEfficiencyGapInsight {
  static String? call(int? savingsPercent, int? extraMinutes) {
    if (savingsPercent == null || extraMinutes == null || savingsPercent <= 0) return null;
    return 'You could save $savingsPercent% by driving $extraMinutes '
        '${extraMinutes == 1 ? 'minute' : 'minutes'} further.';
  }
}
