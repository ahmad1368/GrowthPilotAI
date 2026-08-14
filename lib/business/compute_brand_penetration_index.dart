import 'package:growth_pilot_ai/business/get_regional_category_benchmark.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/core/models/brand_penetration_index.dart';

/// Compares the user's trailing-30-day income against a mocked regional
/// category benchmark (Issue #359) to produce a rough "market share" index.
class ComputeBrandPenetrationIndex {
  static BrandPenetrationIndex call(
    List<TransactionEntity> transactions,
    BusinessSector sector,
  ) {
    final start = DateTime.now().subtract(const Duration(days: 30));
    final userVolume = transactions
        .where((t) => t.type == TransactionType.income && !t.date.isBefore(start))
        .fold(0.0, (sum, t) => sum + t.amount);
    final benchmark = GetRegionalCategoryBenchmark.call(sector);
    final indexPercent = benchmark <= 0 ? 0.0 : (userVolume / benchmark) * 100;

    return BrandPenetrationIndex(
      userVolume: userVolume,
      neighborhoodBenchmarkVolume: benchmark,
      indexPercent: indexPercent,
    );
  }
}
