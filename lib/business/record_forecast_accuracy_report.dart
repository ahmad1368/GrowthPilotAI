import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_forecast_accuracy_report.dart';
import 'package:growth_pilot_ai/core/data/entities/forecast_accuracy_report_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/forecast_accuracy_report_repository.dart';
import 'package:growth_pilot_ai/core/models/forecast_accuracy_report.dart';

/// Builds and persists one billing cycle's MAPE report (Issue #207) —
/// no NestJS cron/Flutter WorkManager job exists to trigger this
/// monthly on its own (this repo has no client-side scheduler at all,
/// per docs/security/retention.md's own prior disclosure); whatever
/// calls this on the 1st of the month is a follow-up.
class RecordForecastAccuracyReport {
  static ForecastAccuracyReport call({
    required double predictedTotal,
    required double actualTotal,
    required String industryType,
    required String region,
    required int dataVolume,
  }) {
    final report = BuildForecastAccuracyReport.call(
      predictedTotal: predictedTotal,
      actualTotal: actualTotal,
      industryType: industryType,
      region: region,
      dataVolume: dataVolume,
    );

    GetIt.I<ForecastAccuracyReportRepository>().add(ForecastAccuracyReportEntity(
      mape: report.mape,
      isCriticalError: report.isCriticalError,
      isOutlier: report.isOutlier,
      industryType: report.industryType,
      region: report.region,
      dataVolume: report.dataVolume,
      createdAt: DateTime.now(),
    ));

    return report;
  }
}
