import 'package:growth_pilot_ai/business/compute_mape.dart';
import 'package:growth_pilot_ai/business/is_critical_mape_error.dart';
import 'package:growth_pilot_ai/business/is_mape_outlier.dart';
import 'package:growth_pilot_ai/core/models/forecast_accuracy_report.dart';

/// Orchestrates Issue #207's MAPE workflow: compares one billing
/// cycle's predicted vs. actual spend and classifies the result.
class BuildForecastAccuracyReport {
  static ForecastAccuracyReport call({
    required double predictedTotal,
    required double actualTotal,
    required String industryType,
    required String region,
    required int dataVolume,
  }) {
    final mape = ComputeMape.call(actualTotal, predictedTotal);
    return ForecastAccuracyReport(
      mape: mape,
      isCriticalError: IsCriticalMapeError.call(mape),
      isOutlier: IsMapeOutlier.call(mape),
      industryType: industryType,
      region: region,
      dataVolume: dataVolume,
    );
  }
}
