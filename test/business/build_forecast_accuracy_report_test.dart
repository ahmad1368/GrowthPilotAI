import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_forecast_accuracy_report.dart';

void main() {
  group('BuildForecastAccuracyReport', () {
    test('an accurate prediction is neither critical nor an outlier', () {
      final report = BuildForecastAccuracyReport.call(
        predictedTotal: 1000,
        actualTotal: 1000,
        industryType: 'Construction',
        region: 'BC',
        dataVolume: 42,
      );

      expect(report.mape, 0);
      expect(report.isCriticalError, isFalse);
      expect(report.isOutlier, isFalse);
    });

    test('a large miss is flagged both critical and an outlier', () {
      final report = BuildForecastAccuracyReport.call(
        predictedTotal: 1500,
        actualTotal: 1000,
        industryType: 'Retail',
        region: 'Ontario',
        dataVolume: 5,
      );

      expect(report.mape, 50);
      expect(report.isCriticalError, isTrue);
      expect(report.isOutlier, isTrue);
    });

    test('carries the industry/region/dataVolume through unchanged', () {
      final report = BuildForecastAccuracyReport.call(
        predictedTotal: 100,
        actualTotal: 100,
        industryType: 'Tech',
        region: 'BC',
        dataVolume: 12,
      );

      expect(report.industryType, 'Tech');
      expect(report.region, 'BC');
      expect(report.dataVolume, 12);
    });
  });
}
