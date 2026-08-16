import 'package:flutter/foundation.dart';

/// One `forecast_accuracy_report` result (Issue #207) — [industryType]/
/// [region]/[dataVolume] are caller-supplied, not derived from a real
/// business profile lookup (see PR notes). No user ID or merchant name
/// is ever part of this shape (AC: "Zero PII").
@immutable
class ForecastAccuracyReport {
  final double mape;
  final bool isCriticalError;
  final bool isOutlier;
  final String industryType;
  final String region;
  final int dataVolume;

  const ForecastAccuracyReport({
    required this.mape,
    required this.isCriticalError,
    required this.isOutlier,
    required this.industryType,
    required this.region,
    required this.dataVolume,
  });
}
