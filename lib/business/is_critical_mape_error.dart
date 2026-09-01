/// "Critical Error Flag" (Issue #207 section 3: "If MAPE > 20% ...
/// trigger a non-PII alert") — a lower, earlier-warning threshold than
/// [IsMapeOutlier]'s 25%.
class IsCriticalMapeError {
  static const thresholdPercent = 20.0;

  static bool call(double mape) => mape > thresholdPercent;
}
