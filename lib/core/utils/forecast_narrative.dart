import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Turns raw [ForecastEngine] numbers into plain-English, CAD-formatted
/// narrative strings — the "voice" of the forecast on the dashboard.
class ForecastNarrative {
  /// Predictions are only meaningful with at least 3 days of real activity.
  static bool hasEnoughData(List<double> history) =>
      history.where((v) => v > 0).length >= 3;

  static double windowTotal(List<double> forecast) => forecast.isEmpty
      ? 0.0
      : double.parse(forecast.reduce((a, b) => a + b).toStringAsFixed(2));

  /// How far the forecast's daily average sits above/below the historical
  /// daily average, as a signed percentage.
  static double comparisonPct(List<double> forecast, List<double> history) {
    final f = AnalyticsUtils.calculateAverage(forecast);
    final h = AnalyticsUtils.calculateAverage(history);
    return AnalyticsUtils.calculateGrowthRate(f, h);
  }

  static String windowTotalLabel(List<double> forecast, int days) =>
      'Projected total for next $days days: '
      '${CurrencyFormat.cad(windowTotal(forecast))}';

  static String singleDayLabel(double amount, String dayName) =>
      'Likely spending for $dayName: ${CurrencyFormat.cad(amount)}';
}
