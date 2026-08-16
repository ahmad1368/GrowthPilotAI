/// "Outliers... flagged for manual review" (Issue #207 AC: "errors >
/// 25%") — a stricter tier than [IsCriticalMapeError]'s 20% alert
/// threshold.
class IsMapeOutlier {
  static const thresholdPercent = 25.0;

  static bool call(double mape) => mape > thresholdPercent;
}
