import 'package:growth_pilot_ai/core/models/financial_comparison.dart';

class AnalyticsUtils {
  static double calculateGrowthRate(double current, double previous) {
    if (previous == 0) return current > 0 ? 100.0 : 0.0;
    final growth = ((current - previous) / previous) * 100;
    return double.parse(growth.toStringAsFixed(2));
  }

  static double calculateAverage(List<double> values) {
    if (values.isEmpty) return 0.0;
    final total = values.reduce((a, b) => a + b);
    return double.parse((total / values.length).toStringAsFixed(2));
  }

  static List<double> movingAverage(List<double> data, int windowSize) {
    if (data.isEmpty || windowSize <= 0 || windowSize > data.length) return [];
    final List<double> result = [];
    for (int i = 0; i <= data.length - windowSize; i++) {
      final sum = data.sublist(i, i + windowSize).reduce((a, b) => a + b);
      result.add(double.parse((sum / windowSize).toStringAsFixed(2)));
    }
    return result;
  }

  static FinancialComparison comparePeriods(
      List<double> current, List<double> previous, bool isExpense) {
    final totalCurrent =
        current.isEmpty ? 0.0 : current.reduce((a, b) => a + b);
    final totalPrevious =
        previous.isEmpty ? 0.0 : previous.reduce((a, b) => a + b);
    final diff = totalCurrent - totalPrevious;
    final rate = calculateGrowthRate(totalCurrent, totalPrevious);

    return FinancialComparison(
      totalDifference: double.parse(diff.toStringAsFixed(2)),
      percentageChange: rate,
      isNegativeTrend: isExpense ? (diff > 0) : (diff < 0),
    );
  }
}
