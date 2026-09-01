/// Pure, on-device moving-average smoothers for the spending trendline.
/// Both produce a series the SAME length as [data] with graceful startup
/// handling (no nulls at the chart's leading edge), ready to feed fl_chart /
/// CustomPainter. Purely a math transform — no new sensitive data is created.
class MovingAverageEngine {
  static double _round(double v) => double.parse(v.toStringAsFixed(2));

  /// Simple Moving Average. During the startup window (first `window - 1`
  /// points) it averages only the data available so far.
  static List<double> calculateSMA(List<double> data, int window) {
    if (data.isEmpty || window < 1) return const <double>[];
    final List<double> sma = [];
    for (int i = 0; i < data.length; i++) {
      final start = i < window - 1 ? 0 : i - window + 1;
      final slice = data.sublist(start, i + 1);
      sma.add(_round(slice.reduce((a, b) => a + b) / slice.length));
    }
    return sma;
  }

  /// Weighted Moving Average — the most recent day carries the largest linear
  /// weight, so it reacts faster to a recent spike than the SMA. Startup
  /// points (first `window - 1`) fall back to the raw value.
  static List<double> calculateWMA(List<double> data, int window) {
    if (data.isEmpty || window < 1) return const <double>[];
    final int weightSum = (window * (window + 1)) ~/ 2;
    final List<double> wma = [];
    for (int i = 0; i < data.length; i++) {
      if (i < window - 1) {
        wma.add(_round(data[i]));
        continue;
      }
      double sum = 0;
      for (int j = 0; j < window; j++) {
        sum += data[i - window + 1 + j] * (j + 1);
      }
      wma.add(_round(sum / weightSum));
    }
    return wma;
  }
}
