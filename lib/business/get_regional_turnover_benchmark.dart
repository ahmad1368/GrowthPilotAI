import 'package:growth_pilot_ai/core/enum/business_sector.dart';

/// Mocked average inventory turnover ratio for Vancouver sector peers
/// (Issue #447) — stands in for the NestJS regional-volume aggregation this
/// repo has no Anonymized Data Lake (#80) to compute a real one from,
/// mirroring [GetRegionalCategoryBenchmark]'s established pattern.
class GetRegionalTurnoverBenchmark {
  static const _turnoverRatio = {
    BusinessSector.construction: 0.6,
    BusinessSector.tech: 1.1,
    BusinessSector.retail: 1.8,
  };

  static double call(BusinessSector sector) => _turnoverRatio[sector]!;
}
