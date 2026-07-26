import 'package:flutter/foundation.dart';

/// Twelve-month profit projection with best/worst-case scenario bands
/// (Issue #399).
@immutable
class AnnualProfitForecast {
  final double expectedAnnualProfit;
  final double bestCaseAnnualProfit;
  final double worstCaseAnnualProfit;
  final String peakMonthLabel;

  const AnnualProfitForecast({
    required this.expectedAnnualProfit,
    required this.bestCaseAnnualProfit,
    required this.worstCaseAnnualProfit,
    required this.peakMonthLabel,
  });
}
