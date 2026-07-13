import 'package:growth_pilot_ai/core/enum/spending_trend.dart';

/// Pure, on-device least-squares linear-regression forecaster. Fits the line
/// y = mx + b to a continuous daily series (e.g. from `TimeSeriesService`) and
/// extrapolates it. All math stays on the local CPU — no sensitive financial
/// trend ever leaves the device.
class ForecastEngine {
  /// Least-squares slope (m). Returns 0.0 for degenerate input (< 2 points
  /// or a zero denominator, i.e. all x identical).
  static double slope(List<double> data) {
    final n = data.length;
    if (n < 2) return 0.0;
    double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;
    for (int i = 0; i < n; i++) {
      final x = i.toDouble();
      sumX += x;
      sumY += data[i];
      sumXY += x * data[i];
      sumX2 += x * x;
    }
    final denom = n * sumX2 - sumX * sumX;
    if (denom == 0) return 0.0;
    return (n * sumXY - sumX * sumY) / denom;
  }

  /// Predicts the next [steps] values via extrapolation. Financial figures
  /// cannot be negative, so predictions are floored at 0.0 and rounded to
  /// two decimal places (Canadian currency precision).
  static List<double> predictNext(List<double> data, int steps) {
    final n = data.length;
    if (n < 2) return List<double>.filled(steps, 0.0);
    final m = slope(data);
    double sumX = 0, sumY = 0;
    for (int i = 0; i < n; i++) {
      sumX += i;
      sumY += data[i];
    }
    final b = (sumY - m * sumX) / n;
    return List<double>.generate(steps, (i) {
      final pred = m * (n + i) + b;
      return pred < 0 ? 0.0 : double.parse(pred.toStringAsFixed(2));
    });
  }

  /// Classifies the overall direction of the series.
  static SpendingTrend detectTrend(List<double> data) {
    final m = slope(data);
    if (m > 0) return SpendingTrend.rising;
    if (m < 0) return SpendingTrend.falling;
    return SpendingTrend.flat;
  }
}
