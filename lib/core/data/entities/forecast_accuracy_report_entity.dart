import 'package:objectbox/objectbox.dart';

/// One persisted `forecast_accuracy_report` event (Issue #207) — no
/// Firebase Analytics is integrated (same decision as #209/#210), so
/// this is the local buffer. No user ID or merchant name is ever
/// stored here (AC: "Zero PII").
@Entity()
class ForecastAccuracyReportEntity {
  @Id()
  int id = 0;

  double mape;
  bool isCriticalError;
  bool isOutlier;
  String industryType;
  String region;
  int dataVolume;
  DateTime createdAt;

  ForecastAccuracyReportEntity({
    this.id = 0,
    required this.mape,
    required this.isCriticalError,
    required this.isOutlier,
    required this.industryType,
    required this.region,
    required this.dataVolume,
    required this.createdAt,
  });
}
