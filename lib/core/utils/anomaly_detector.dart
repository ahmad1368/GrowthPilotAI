import 'dart:math';

/// Pure, on-device statistical guard: flags spending days that fall outside
/// mean ± 2σ (Z-score, ~95% confidence) so a single anomalous entry doesn't
/// distort the forecast. All analysis stays local.
class AnomalyDetector {
  static const int _minBaseline = 10;
  static const double _threshold = 2.0;

  static double mean(List<double> data) =>
      data.isEmpty ? 0.0 : data.reduce((a, b) => a + b) / data.length;

  static double standardDeviation(List<double> data) {
    if (data.isEmpty) return 0.0;
    final m = mean(data);
    final variance =
        data.map((x) => pow(x - m, 2).toDouble()).reduce((a, b) => a + b) /
            data.length;
    return sqrt(variance);
  }

  /// Absolute Z-score distance of [current] from the [history] baseline.
  static double zScore(double current, List<double> history) {
    final sd = standardDeviation(history);
    if (sd == 0) return 0.0;
    return (current - mean(history)).abs() / sd;
  }

  /// True when [current] is a statistical outlier. Requires at least 10
  /// baseline points to avoid early false positives.
  static bool isOutlier(double current, List<double> history) {
    if (history.length < _minBaseline) return false;
    return zScore(current, history) > _threshold;
  }

  /// Indices within [series] that are outliers against the whole set.
  static List<int> detectAnomalies(List<double> series) {
    if (series.length < _minBaseline) return const [];
    final sd = standardDeviation(series);
    if (sd == 0) return const [];
    final m = mean(series);
    final result = <int>[];
    for (int i = 0; i < series.length; i++) {
      if ((series[i] - m).abs() / sd > _threshold) result.add(i);
    }
    return result;
  }
}
