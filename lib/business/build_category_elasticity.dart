import 'package:growth_pilot_ai/business/bucket_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';
import 'package:growth_pilot_ai/core/models/category_elasticity.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

/// Builds one category's [CategoryElasticity] from its monthly price and
/// volume series (Issue #380).
class BuildCategoryElasticity {
  static CategoryElasticity call(String categoryName, List<TransactionEntity> transactions) {
    final monthly = BucketTransactionsByPeriod.call(transactions, MarginPeriod.monthly);
    final months = monthly.keys.toList()..sort();
    final overallAvg =
        transactions.fold(0.0, (sum, t) => sum + t.amount) / transactions.length;

    if (months.length < 2) {
      return CategoryElasticity(
        categoryName: categoryName,
        averagePrice: overallAvg,
        priceTrend: SpendingTrend.flat,
        volumeTrend: SpendingTrend.flat,
        hint: ElasticityHint.insufficient,
      );
    }

    final avgPrices = months.map((m) {
      final txs = monthly[m]!;
      return txs.fold(0.0, (sum, t) => sum + t.amount) / txs.length;
    }).toList();
    final volumes = months.map((m) => monthly[m]!.length.toDouble()).toList();

    final priceTrend = ForecastEngine.detectTrend(avgPrices);
    final volumeTrend = ForecastEngine.detectTrend(volumes);
    final hint = priceTrend != SpendingTrend.rising
        ? ElasticityHint.insufficient
        : (volumeTrend == SpendingTrend.falling
            ? ElasticityHint.elastic
            : ElasticityHint.inelastic);

    return CategoryElasticity(
      categoryName: categoryName,
      averagePrice: overallAvg,
      priceTrend: priceTrend,
      volumeTrend: volumeTrend,
      hint: hint,
    );
  }
}
