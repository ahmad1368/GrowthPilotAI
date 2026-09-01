/// A CRA tax-season prompt suggestion (Issue #201's "Current Date...
/// If it's April, suggest 'Summarize my Q1 taxes'") — null outside the
/// Jan-Apr filing window this app's issue text targets.
class BuildSeasonalPrompt {
  static String? call(DateTime now) {
    if (now.month > 4) return null;
    return 'Analyze my ${now.year - 1} tax deductions';
  }
}
