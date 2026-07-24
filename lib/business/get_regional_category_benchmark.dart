import 'package:growth_pilot_ai/core/enum/business_sector.dart';

/// Mocked average monthly revenue for a merchant's category within their
/// neighborhood (Issue #359) — stands in for the NestJS regional-volume
/// aggregation this repo has no Anonymized Data Lake (#80) to compute a
/// real one from, mirroring [GetSectorBenchmark]'s established pattern.
class GetRegionalCategoryBenchmark {
  static const _monthlyVolume = {
    BusinessSector.construction: 42000.0,
    BusinessSector.tech: 28000.0,
    BusinessSector.retail: 35000.0,
  };

  static double call(BusinessSector sector) => _monthlyVolume[sector]!;
}
