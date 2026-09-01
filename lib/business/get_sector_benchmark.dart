import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

/// Mocked "Success Vector" per BC sector (Issue #84): stands in for the
/// NestJS `SuccessSignatureService`'s weekly-recalculated benchmark (Issue
/// #83), since no Anonymized Data Lake (Issue #80) or Differential Privacy
/// layer (Issue #81) exists in this repo to compute a real one from.
class GetSectorBenchmark {
  static const _benchmarks = {
    BusinessSector.construction: BusinessCompassMetrics(
      liquidityRatio: 0.62,
      burnVelocity: 0.55,
      vendorDiversity: 0.70,
      paymentPunctuality: 0.80,
      profitMargin: 0.35,
    ),
    BusinessSector.tech: BusinessCompassMetrics(
      liquidityRatio: 0.80,
      burnVelocity: 0.45,
      vendorDiversity: 0.40,
      paymentPunctuality: 0.90,
      profitMargin: 0.55,
    ),
    BusinessSector.retail: BusinessCompassMetrics(
      liquidityRatio: 0.50,
      burnVelocity: 0.60,
      vendorDiversity: 0.85,
      paymentPunctuality: 0.70,
      profitMargin: 0.25,
    ),
  };

  static BusinessCompassMetrics call(BusinessSector sector) =>
      _benchmarks[sector]!;
}
