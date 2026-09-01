/// Whether today's transaction total has exceeded the configured daily
/// cap and new transactions should be temporarily blocked (Issue #344,
/// acceptance criterion 2).
class CheckDailyCapBreach {
  static bool call(double dailyTotal, double capAmount) => dailyTotal > capAmount;
}
